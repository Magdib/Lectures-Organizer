import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:unversityapp/core/Constant/HiveData/HiveKeysBoxes.dart';
import 'package:unversityapp/core/class/enums/LectureState.dart';
import 'package:unversityapp/model/HiveAdaptersModels/LecturesAdapter.dart';
import 'package:share_plus/share_plus.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:unversityapp/view/Widgets/shared/BlueSnackBar.dart';

abstract class LectureViewController extends GetxController {
  void showContextMenu(
      BuildContext context, PdfTextSelectionChangedDetails details);
  void onTextSelectionChanged(
      PdfTextSelectionChangedDetails details, BuildContext context);
  void hideShowAppBar();
  void handleMenuSelection(int val, BuildContext context);
  void saveLecture();
  void addToBookMark();
  void completeLecture();
  void shareLecture();
  void openLastTime();
  void handlePdfError(PdfDocumentLoadFailedDetails d);
}

class LectureViewControllerImp extends LectureViewController {
  LecturesPageModel lectureData = Get.arguments["lecture"];
  final int lectureIndex = Get.arguments["Index"];
  final int where = Get.arguments["Where"];
  int? recentIndex = Get.arguments["RecentIndex"];
  final Box userDataBox = Hive.box(HiveBoxes.userDataBox);
  final Box<LecturesPageModel> lecturesBox = Hive.box(HiveBoxes.lecturesBox);
  late String lecturename;
  late String lecturepath;
  late double offset;
  final PdfViewerController pdfViewerController = PdfViewerController();
  bool show = true;
  double appBarHeight = 50;
  final double maxAppBarHeight = 50;
  final double minAppBarHeight = 0;
  Timer? _timer;
  Timer? minTimer;
  double? time;
  LectureState lectureState = LectureState.view1;
  OverlayEntry? _overlayEntry;
  String errorText = '';
  @override
  void showContextMenu(
      BuildContext context, PdfTextSelectionChangedDetails details) {
    final OverlayState overlayState = Overlay.of(context);

    _overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: details.globalSelectedRegion!.center.dy - 55,
        left: details.globalSelectedRegion!.bottomLeft.dx,
        child: MaterialButton(
          onPressed: () {
            Clipboard.setData(ClipboardData(text: details.selectedText));
            pdfViewerController.clearSelection();
          },
          color: Colors.white,
          elevation: 10,
          child: Text('نسخ', style: Theme.of(context).textTheme.headline2),
        ),
      ),
    );

    overlayState.insert(_overlayEntry!);
  }

  @override
  void onTextSelectionChanged(
      PdfTextSelectionChangedDetails details, BuildContext context) {
    if (details.selectedText == null && _overlayEntry != null) {
      _overlayEntry!.remove();
      _overlayEntry = null;
    } else if (details.selectedText != null && _overlayEntry == null) {
      showContextMenu(context, details);
    }
  }

  @override
  void openLastTime() {
    lectureData.offset = pdfViewerController.scrollOffset.dy;
    lecturesBox.putAt(lectureIndex, lectureData);
  }

  @override
  void handleMenuSelection(int val, BuildContext context) {
    if (val == 0) {
      shareLecture();
    } else if (val == 1) {
      saveLecture();
      blueSnackBar(
          lecturename,
          'تم تحميل المحاضرة $lecturename وتخزينها في ذاكرة الجهاز في ملف محاضراتي',
          context);
    } else if (val == 2) {
      addToBookMark();
    } else if (val == 3) {
      completeLecture();
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
    PermissionStatus p = await Permission.storage.status;
    if (p.isDenied) {
      await Permission.storage.request();
    }

    String dir = '/storage/emulated/0/محاضراتي';
    Directory? lectureDir = Directory(dir);
    if (lectureDir.existsSync() == false) {
      Directory(dir).createSync();
    }
    File(lecturepath).copySync('$dir/$lecturename');
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
    super.onInit();
  }

  @override
  void onClose() {
    userDataBox.put(HiveKeys.studyTime, time);
    _timer!.cancel();
    minTimer!.cancel();
    super.onClose();
  }
}
