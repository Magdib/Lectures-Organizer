import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:unversityapp/controller/NormalUsePagesControllers/SubjectsPageController.dart';
import 'package:unversityapp/core/Constant/HiveData/HiveKeysBoxes.dart';
import 'package:unversityapp/core/Routes/routes.dart';
import 'package:unversityapp/core/class/enums/DataState.dart';
import 'package:unversityapp/core/functions/Dialogs/LecturesDialogs.dart';
import 'package:unversityapp/core/functions/validation/TermStringToInt.dart';
import 'package:unversityapp/model/HiveAdaptersModels/SubjectsAdapter.dart';

import '../../core/class/enums/ChooseIconState.dart';
import '../../core/functions/GlobalFunctions/addToRecent.dart';
import '../../core/functions/GlobalFunctions/getLectures.dart';
import '../../model/HiveAdaptersModels/LecturesAdapter.dart';
import '../../core/functions/snackBars/ErrorSnackBar.dart';
import '../../view/Widgets/shared/BlueSnackBar.dart';

abstract class LecturePageController extends GetxController {
  List<LecturesPageModel> lectureToCurrent();
  int currentIndexToLectures(int index);
  void choosePR();
  void chooseVI();
  void handleLectureButtonState();
  void pickLectures();
  void lectureTypeFun(String type, int index);
  void addLecture();
  void onWillPop();
  void deleteSubject(BuildContext context);
  void shareSubject();
  void handelDSTap();

  void filterLectures(String value);
  void filterTypeFun(String value);
  void deleteLecture(int index);
  void completeLecture(int index);
  void completedLecturesCheck();
  void addToBookMark(int index, BuildContext context);
  void clearCach();
  void openLecture(int index);
  void refreshData(int state);
  void getNumberOfPages(
      PdfDocumentLoadedDetails details, BuildContext context, int index);
  onWillPopDetailes();
}

class LecturePageControllerimp extends LecturePageController {
  String subjectname = Get.arguments['subjectname'];
  int subjectindex = Get.arguments["subjectIndex"];
  Box userDataBox = Hive.box(HiveBoxes.userDataBox);
  Box<SubjectsPageModel> subjectsBox = Hive.box(HiveBoxes.subjectsBox);
  Box<LecturesPageModel> lecturesBox = Hive.box(HiveBoxes.lecturesBox);
  late Box<LecturesPageModel> recentBox;
  bool lectureButtonState = false;
  List<LecturesPageModel> lectures = [];
  List<LecturesPageModel> currentLectures = [];
  List<LecturesPageModel> recentLectures = [];
  List<String> filesPathes = [];
  List<String> lecturesNames = [];
  TextEditingController? filterEditController;
  bool canComplete = true;
  late String lectureType;

  late int completedLectures;
  late int numberofLectures;
  late double percent = 0;
  late String randomAdvice;
  late DataState dataState = DataState.loading;
  ChooseIconState iconState = ChooseIconState.empty;
  bool vi = false, pr = false;

  @override
  List<LecturesPageModel> lectureToCurrent() {
    List<LecturesPageModel> currentList;
    currentList = lectures
        .where((lecture) => lecture.oldid.contains(subjectname))
        .toList();
    return currentList;
  }

  @override
  int currentIndexToLectures(int index) {
    return lectures.indexWhere((lecture) =>
        lecture.lecturename.contains(currentLectures[index].lecturename));
  }

  @override
  void pickLectures() async {
    lecturesNames.clear();
    filesPathes.clear();
    iconState = ChooseIconState.loading;
    update();
    FilePickerResult? result = await FilePicker.platform.pickFiles(
        allowedExtensions: ['pdf'], type: FileType.custom, allowMultiple: true);

    if (result != null) {
      Directory? dataDir = await getExternalStorageDirectory();

      for (int i = 0; i < result.files.length; i++) {
        PlatformFile pieckedFile = result.files[i];
        File cachefile = File(pieckedFile.path!);
        File savedFile =
            await cachefile.copy('${dataDir!.path}/${result.names[i]}');
        filesPathes.add(savedFile.path);
        lecturesNames.add(pieckedFile.name);
        handleLectureButtonState();
      }
      iconState = ChooseIconState.completed;
    } else {
      iconState = ChooseIconState.empty;
    }
    update();
  }

  @override
  void lectureTypeFun(String type, int index) {
    SubjectsPageControllerimp controller = Get.find();
    lectures.add(LecturesPageModel(
        lecturename: lecturesNames[index],
        lecturetype: type,
        lecturepath: filesPathes[index],
        oldid: subjectname,
        check: false,
        time: DateTime.now().toString(),
        bookMarked: false,
        offset: 0.1,
        numberofPages: 0));
    if (lectureType == type || lectureType == "الكل") {
      currentLectures.add(LecturesPageModel(
          lecturename: lecturesNames[index],
          lecturetype: type,
          lecturepath: filesPathes[index],
          oldid: subjectname,
          check: false,
          time: DateTime.now().toString(),
          bookMarked: false,
          offset: 0.1,
          numberofPages: 0));
    }
    lecturesBox.add(lectures[lectures.length - 1]);
    numberofLectures++;
    controller.subjects[subjectindex].numberoflecture++;
    subjectsBox.putAt(subjectindex, controller.subjects[subjectindex]);
    userDataBox.put(HiveKeys.lecturesNumber, lectures.length);
  }

  @override
  void addLecture() async {
    Get.back();
    for (int i = 0; i < lecturesNames.length; i++) {
      if (lectures
              .where(
                  (lecture) => lecture.lecturename.contains(lecturesNames[i]))
              .isNotEmpty ==
          true) {
        errorSnackBar('المحاضرة موجودة سابقاً',
            "الرجاء إضافة محاضرة أخرى أو تغيير اسم المحاضرة في حالة تطابق الأسماء");
      } else {
        if (lecturesNames[i] != '') {
          if (pr == true) {
            lectureTypeFun('عملي', i);
          } else {
            lectureTypeFun('نظري', i);
          }
        }
      }
    }
    if (currentLectures.isNotEmpty) {
      dataState = DataState.notEmpty;
    }
    lecturesNames.clear();
    filesPathes.clear();
    handleLectureButtonState();
    iconState = ChooseIconState.empty;
    update();
  }

  @override
  void choosePR() {
    vi = false;
    pr = true;
    handleLectureButtonState();
    update();
  }

  @override
  void chooseVI() {
    vi = true;
    pr = false;
    handleLectureButtonState();
    update();
  }

  @override
  void handleLectureButtonState() {
    if (lecturesNames.isNotEmpty && (pr == true || vi == true)) {
      lectureButtonState = true;
    } else {
      lectureButtonState = false;
    }
    update();
  }

  @override
  void onWillPop() async {
    for (int i = 0; i < filesPathes.length; i++) {
      if (lectures
          .where((lecture) => lecture.lecturepath.contains(filesPathes[i]))
          .isEmpty) {
        File(filesPathes[i]).deleteSync();
      }
    }
    lecturesNames.clear();
    filesPathes.clear();
    vi = false;
    pr = false;
    handleLectureButtonState();
    iconState = ChooseIconState.empty;

    Get.back();
  }

  @override
  void filterTypeFun(String value) {
    lectureType = value;
    switch (lectureType) {
      case "الكل":
        currentLectures = lectures
            .where((lecture) => lecture.oldid.contains(subjectname))
            .toList();
        break;
      case "عملي":
        currentLectures = lectures.where((lecture) {
          return lecture.oldid.contains(subjectname) &&
              lecture.lecturetype == "عملي";
        }).toList();

        break;
      case "نظري":
        currentLectures = lectures.where((lecture) {
          return lecture.oldid.contains(subjectname) &&
              lecture.lecturetype == "نظري";
        }).toList();

        break;
      default:
    }
    if (currentLectures.isNotEmpty && dataState == DataState.empty) {
      dataState = DataState.notEmpty;
    }
    completedLecturesCheck();
    userDataBox.put(HiveKeys.lectureType, lectureType);
    filterEditController!.clear();
    update();
  }

  @override
  void filterLectures(String value) {
    List<LecturesPageModel> result = [];
    String currentType = lectureTypeFunction(lectureType);
    if (value.isNotEmpty) {
      canComplete = false;
      if (lectureType != 'الكل') {
        result = lectures
            .where((lecture) =>
                lecture.oldid.contains(subjectname) &&
                lecture.lecturename.contains(value) &&
                lecture.lecturetype == currentType)
            .toList();
      } else {
        result = lectures
            .where((lecture) =>
                lecture.oldid.contains(subjectname) &&
                lecture.lecturename.contains(value))
            .toList();
      }
    } else {
      canComplete = true;
      if (lectureType != 'الكل') {
        result = lectures
            .where((lecture) =>
                lecture.oldid.contains(subjectname) &&
                lecture.lecturetype == currentType)
            .toList();
      } else {
        result = lectureToCurrent();
      }
    }
    currentLectures = result;
    update();
  }

  @override
  void handelDSTap() {
    filterEditController!.clear();
    lectureType = "الكل";
    currentLectures = lectureToCurrent();
    update();
  }

  @override
  void completeLecture(int index) {
    int lectureIndex = currentIndexToLectures(index);
    lectures[lectureIndex].check = !lectures[lectureIndex].check;
    lecturesBox.putAt(lectureIndex, lectures[lectureIndex]);
    filterTypeFun(lectureType);
    completedLecturesCheck();

    update();
  }

  @override
  void completedLecturesCheck() {
    completedLectures = currentLectures
        .where((lecture) => lecture.check == true)
        .toList()
        .length;
    if (completedLectures != 0) {
      percent = (completedLectures / currentLectures.length);
    } else {
      percent = 0;
    }
  }

  @override
  void addToBookMark(int index, BuildContext context) {
    int lectureIndex = currentIndexToLectures(index);
    lectures[lectureIndex].bookMarked = !lectures[lectureIndex].bookMarked;
    lecturesBox.putAt(lectureIndex, lectures[lectureIndex]);
    if (lectures[lectureIndex].bookMarked == true) {
      blueSnackBar(
          currentLectures[index].lecturename,
          'تم إضافة المحاضرة ${currentLectures[index].lecturename} إلى المحفوظات بنجاح',
          context);
    } else {
      blueSnackBar(
          currentLectures[index].lecturename,
          'تم إزالة المحاضرة ${currentLectures[index].lecturename} من المحفوظات بنجاح',
          context);
    }
    update();
  }

  @override
  void deleteSubject(BuildContext context) async {
    SubjectsPageControllerimp subjectsController = Get.find();

    subjectsController.subjects.removeAt(subjectindex);
    subjectsController.subjectsBox.deleteAt(subjectindex);
    subjectsController.numberOfSubjects--;
    userDataBox.put(
        HiveKeys.subjectsNumber, subjectsController.numberOfSubjects);
    Get.offAllNamed(
      AppRoutes.homePageRoute,
    );
    int lectureIndex = 0;
    for (int i = 0; i < currentLectures.length; i++) {
      lectureIndex = lectures
          .lastIndexWhere((lecture) => lecture.oldid.contains(subjectname));
      File(lectures[lectureIndex].lecturepath).deleteSync();
      lectures.removeAt(lectureIndex);
      lecturesBox.deleteAt(lectureIndex);
      numberofLectures--;
    }
    userDataBox.put(HiveKeys.lecturesNumber, numberofLectures);
    blueSnackBar(subjectname, 'تم حذف المادة بنجاح', context);
  }

  @override
  void shareSubject() {
    List<XFile> sharedSubject = [];
    for (int i = 0; i < currentLectures.length; i++) {
      sharedSubject.add(XFile(currentLectures[i].lecturepath));
    }
    Share.shareXFiles(sharedSubject);
  }

  @override
  void deleteLecture(int index) async {
    SubjectsPageControllerimp subjectsPageControllerimp = Get.find();
    Get.back();
    int deleteIndex = currentIndexToLectures(index);
    File(currentLectures[index].lecturepath).deleteSync();
    lecturesBox.deleteAt(deleteIndex);
    lectures.removeAt(deleteIndex);
    currentLectures.removeAt(index);
    subjectsPageControllerimp.subjects[subjectindex].numberoflecture--;
    subjectsBox.putAt(
        subjectindex, subjectsPageControllerimp.subjects[subjectindex]);

    if (currentLectures.isEmpty) {
      dataState = DataState.empty;
    }
    completedLecturesCheck();
    update();
  }

  @override
  void clearCach() async {
    Directory cachDir = await getTemporaryDirectory();
    cachDir.deleteSync(recursive: true);
  }

  @override
  void getNumberOfPages(
      PdfDocumentLoadedDetails details, BuildContext context, int index) {
    int lectureIndex = currentIndexToLectures(index);
    lectures[lectureIndex].numberofPages = details.document.pages.count;

    lecturesBox.putAt(lectureIndex, lectures[lectureIndex]);
    Get.back();
    lectureDataDialog(context, index);
  }

  @override
  onWillPopDetailes() {
    Get.back();
    return Future.value(true);
  }

  @override
  void openLecture(int index) {
    int lectureIndex = currentIndexToLectures(index);
    addtorecent(index, currentLectures, recentLectures, lectureIndex);
    Get.toNamed(AppRoutes.lectureViewRoute, arguments: {
      "lecture": currentLectures[index],
      "Index": currentIndexToLectures(index),
      "Where": 0
    });
  }

  @override
  void refreshData(int state) {
    lectures.clear();
    getLectures(userDataBox, lecturesBox, lectures);
    lectureType == "الكل"
        ? currentLectures = lectureToCurrent()
        : currentLectures = lectures
            .where((lecture) =>
                lecture.oldid.contains(subjectname) &&
                lecture.lecturetype == lectureType)
            .toList();
    completedLecturesCheck();
    if (state == 1) {
      update();
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
          overlays: SystemUiOverlay.values);
    }
  }

  @override
  void onReady() async {
    recentBox = await Hive.openBox(HiveBoxes.recentBox);
    refreshData(0);

    if (recentBox.isNotEmpty) {
      for (int i = 0; i < recentBox.length; i++) {
        recentLectures.add(recentBox.getAt(i)!);
      }
    }

    numberofLectures = currentLectures.length;
    if (currentLectures.isNotEmpty) {
      dataState = DataState.notEmpty;
    } else {
      dataState = DataState.empty;
    }
    update();
    super.onReady();
  }

  @override
  void onInit() {
    filterEditController = TextEditingController();
    if (userDataBox.get(HiveKeys.lecturesNumber) != null &&
        userDataBox.get(HiveKeys.lecturesNumber) != 0) {
      dataState = DataState.loading;
    } else {
      dataState = DataState.empty;
    }
    userDataBox.get(HiveKeys.lectureType) != null
        ? lectureType = userDataBox.get(HiveKeys.lectureType)
        : lectureType = "الكل";
    super.onInit();
  }

  @override
  void onClose() {
    filterEditController!.dispose();
    super.onClose();
  }
}
