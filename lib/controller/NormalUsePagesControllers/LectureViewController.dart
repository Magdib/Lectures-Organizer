import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:unversityapp/core/Constant/HiveData/HiveKeysBoxes.dart';
import 'package:unversityapp/core/class/enums/LectureState.dart';
import 'package:unversityapp/core/functions/snackBars/ErrorSnackBar.dart';
import 'package:unversityapp/model/HiveAdaptersModels/NormalUseModels/LecturesAdapter.dart';
import 'package:share_plus/share_plus.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:unversityapp/view/Widgets/shared/BlueSnackBar.dart';
import 'package:unversityapp/view/Widgets/shared/DialogButton.dart';
import 'package:unversityapp/view/Widgets/shared/CustomTextField.dart';
import '../../core/functions/GlobalFunctions/hiveNullCheck.dart';

abstract class LectureViewController extends GetxController {
  void handleMenuSelection(int val);
  void saveLecture();
  void addToBookMark();
  void completeLecture();
  void shareLecture();
  void openLastTime();
  void searchPdf();
  void hideShowAppBar();
  void handlePdfError(PdfDocumentLoadFailedDetails d);
}

class LectureViewControllerImp extends LectureViewController {
  LecturesPageModel lectureData = Get.arguments["lecture"];
  final int lectureIndex = Get.arguments["Index"];
  final int where = Get.arguments["Where"];
  int? recentIndex = Get.arguments["RecentIndex"];
  final int selectedViewer = Get.arguments["viewer"];
  final Box userDataBox = Hive.box(HiveBoxes.userDataBox);
  final Box<LecturesPageModel> lecturesBox = Hive.box(HiveBoxes.lecturesBox);
  late bool isDarkMode;
  late String lecturename;
  late String lecturepath;
  late double offset;
  late PdfViewerController pdfViewerController;
  late TextEditingController searchController;
  bool show = true;
  double appBarHeight = 50;
  final double maxAppBarHeight = 50;
  final double minAppBarHeight = 0;
  Timer? _timer;
  Timer? minTimer;
  double? time;
  late LectureState lectureState;
  String errorText = '';

  @override
  void openLastTime() {
    lectureData.offset = pdfViewerController.scrollOffset.dy;
    lecturesBox.putAt(lectureIndex, lectureData);
  }

  @override
  void handleMenuSelection(int val) {
    if (val == 0) {
      shareLecture();
    } else if (val == 1) {
      saveLecture();
    } else if (val == 2) {
      addToBookMark();
    } else if (val == 3) {
      completeLecture();
    } else if (val == 4) {
      searchPdf();
    } else {
      hideShowAppBar();
    }
    update();
  }

  @override
  void shareLecture() {
    Share.shareXFiles([XFile(lecturepath)]);
  }

  @override
  void saveLecture() async {
    try {
      PermissionStatus p = await Permission.storage.status;
      if (p.isDenied) {
        await Permission.storage.request();
      } else {
        String dir = "/storage/emulated/0/Download/منسق المحاضرات";
        Directory? lectureDir = Directory(dir);
        if (lectureDir.existsSync() == false) {
          Directory(dir).createSync();
        }
        File(lecturepath).copySync('$dir/$lecturename');
        blueSnackBar(lecturename,
            'تم تحميل المحاضرة $lecturename وتخزينها في ذاكرة الجهاز');
      }
    } catch (e) {
      errorSnackBar("خطأ", "الخدمة غير مدعومة في نظامك");
    }
  }

  @override
  void addToBookMark() {
    lectureData.bookMarked = !lectureData.bookMarked;
    lecturesBox.putAt(lectureIndex, lectureData);
  }

  @override
  void completeLecture() {
    lectureData.check = !lectureData.check;
    lecturesBox.putAt(lectureIndex, lectureData);
  }

  @override
  void searchPdf() {
    Get.defaultDialog(
        titlePadding: const EdgeInsets.only(top: 8, bottom: 0),
        contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 13),
        title: 'بحث',
        titleStyle: Get.textTheme.headline1,
        content: CustomTextField(
            hint: "أدخل كلمة البحث هنا...",
            editingController: searchController),
        cancel: DialogButton(
          text: "إلغاء",
          onPressed: () {
            Get.back();
          },
        ),
        confirm: DialogButton(
          text: "تأكيد",
          onPressed: () {
            Get.back();
            pdfViewerController.searchText(searchController.text);
          },
        ));
  }

  @override
  void hideShowAppBar() async {
    if (appBarHeight == minAppBarHeight) {
      appBarHeight = maxAppBarHeight;
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
          overlays: SystemUiOverlay.values);
    } else {
      appBarHeight = minAppBarHeight;
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    }
  }

  @override
  void handlePdfError(PdfDocumentLoadFailedDetails d) {
    lectureState = LectureState.loadingFailed;
    errorText = d.description;
    update();
  }

  @override
  void onInit() {
    selectedViewer == 0
        ? lectureState = LectureState.view1
        : lectureState = LectureState.view2;
    pdfViewerController = PdfViewerController();
    searchController = TextEditingController();
    isDarkMode = hiveNullCheck(HiveKeys.isDarkMood, false);
    lecturename = lectureData.lecturename;
    lecturepath = lectureData.lecturepath;
    offset = lectureData.offset;
    if (userDataBox.get(HiveKeys.studyTime) == null ||
        userDataBox.get(HiveKeys.studyTime) == 0) {
      time = 0;
    } else {
      time = userDataBox.get(HiveKeys.studyTime);
    }
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      time = time! + (1 / 3600);
    });
    minTimer = Timer.periodic(const Duration(minutes: 3), (timer) {
      userDataBox.put(HiveKeys.studyTime, time);
    });
    // log("$where");
    super.onInit();
  }

  @override
  void onClose() {
    pdfViewerController.dispose();
    searchController.dispose();
    userDataBox.put(HiveKeys.studyTime, time);
    _timer!.cancel();
    minTimer!.cancel();
    super.onClose();
  }
}
