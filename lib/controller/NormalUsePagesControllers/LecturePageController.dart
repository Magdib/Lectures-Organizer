import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:unversityapp/controller/NormalUsePagesControllers/SubjectsPageController.dart';
import 'package:unversityapp/core/Constant/HiveData/HiveKeysBoxes.dart';
import 'package:unversityapp/core/Routes/routes.dart';
import 'package:unversityapp/core/class/app_toasts.dart';
import 'package:unversityapp/core/class/enums/DataState.dart';
import 'package:unversityapp/core/class/enums/lectures_dial_state.dart';
import 'package:unversityapp/core/functions/Dialogs/LecturesDialogs.dart';
import 'package:unversityapp/core/functions/GlobalFunctions/hiveNullCheck.dart';
import 'package:unversityapp/core/functions/validation/TermStringToInt.dart';
import 'package:unversityapp/core/services/Services.dart';
import 'package:unversityapp/model/HiveAdaptersModels/NormalUseModels/SubjectsAdapter.dart';
import 'package:unversityapp/view/Widgets/shared/CustomTextField.dart';
import 'package:unversityapp/view/Widgets/shared/DialogButton.dart';

import '../../core/class/enums/ChooseIconState.dart';
import '../../core/functions/GlobalFunctions/addToRecent.dart';
import '../../core/functions/GlobalFunctions/getLectures.dart';
import '../../model/HiveAdaptersModels/NormalUseModels/LecturesAdapter.dart';

abstract class LecturePageController extends GetxController {
  List<LecturesPageModel> lectureToCurrent();
  int currentIndexToLectures(int index);
  void changeDialState();
  void handleChoosingDial(LecturesDialState chosenLecturesDial);
  void choosePR();
  void chooseVI();
  void chooseEX();
  void handleLectureButtonState();
  Future<void> pickLectures();
  void lectureTypeFun(String type, int index);
  void addLecture();
  void countTotalPages(BuildContext context);
  void onWillPop();
  void deleteSubject(BuildContext context);
  void shareSubject();
  void handelDSTap();
  void filterLectures(String value);
  void filterTypeFun(String value);
  void deleteLecture(int index);
  void completeLecture(int index);
  void completedLecturesCheck();
  void addToBookMark(int index);
  void clearCache();
  void handleLecturesTap(int index);
  void editLectureName(int index);
  void shareLectureDial();
  void deleteLectureDial();
  Future<void> openLecture(int index);
  void refreshData(int state);
  int getNumberOfPages(
      PdfDocumentLoadedDetails details, BuildContext context, int index);
  onWillPopDetailes();
}

class LecturePageControllerimp extends LecturePageController {
  late String subjectname;
  late int subjectindex;
  Box userDataBox = Hive.box(HiveBoxes.userDataBox);
  Box<SubjectsPageModel> subjectsBox = Hive.box(HiveBoxes.subjectsBox);
  Box<LecturesPageModel> lecturesBox = Hive.box(HiveBoxes.lecturesBox);
  late Box<LecturesPageModel> recentBox;
  bool lectureButtonState = false;
  ValueNotifier<bool> isDialOpen = ValueNotifier(false);
  List<LecturesPageModel> lectures = [];
  List<LecturesPageModel> currentLectures = [];
  List<LecturesPageModel> recentLectures = [];
  List<String> filesPathes = [];
  List<String> lecturesNames = [];
  TextEditingController? filterEditController;
  bool canComplete = true;
  late String lectureType;
  bool audioPlay = false;
  late int completedLectures;
  late int numberofLectures;
  late double percent = 0;
  late String randomAdvice;
  late DataState dataState = DataState.loading;
  ChooseIconState iconState = ChooseIconState.empty;
  bool vi = false, pr = false, ex = false;
  late int selectedViewer;
  Timer? timer;
  Timer? minTimer;
  double? time;
  bool isChoosing = false;
  LecturesDialState lecturesDialState = LecturesDialState.none;
  List<int> dialChosenIndexes = [];
  @override
  List<LecturesPageModel> lectureToCurrent() {
    List<LecturesPageModel> currentList;
    currentList =
        lectures.where((lecture) => lecture.oldid == subjectname).toList();
    return currentList;
  }

  @override
  int currentIndexToLectures(int index) {
    return lectures.indexWhere((lecture) =>
        lecture.lecturename.contains(currentLectures[index].lecturename));
  }

  @override
  Future<void> pickLectures() async {
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
        log(savedFile.path);
        filesPathes.add(savedFile.path);
        lecturesNames.add(pieckedFile.name);
      }
      handleLectureButtonState();
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
              .where((lecture) => lecture.lecturename == lecturesNames[i])
              .isNotEmpty ==
          true) {
        AppToasts.showErrorToast('المحاضرة موجودة سابقاً');
      } else {
        if (lecturesNames[i] != '') {
          if (pr) {
            lectureTypeFun('عملي', i);
          } else if (vi) {
            lectureTypeFun('نظري', i);
          } else {
            lectureTypeFun("دورة", i);
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
    completedLecturesCheck();
    iconState = ChooseIconState.empty;
    update();
  }

  @override
  void changeDialState() {
    isChoosing = !isChoosing;
    if (isChoosing) {
      AppToasts.successToast("تم تفعيل وضع الأختيار");
    } else {
      AppToasts.showErrorToast("تم إلغاء وضع الأختيار");
      lecturesDialState = LecturesDialState.none;
      for (int i = 0; i < dialChosenIndexes.length; i++) {
        currentLectures[dialChosenIndexes[i]].chosen = false;
      }
      dialChosenIndexes.clear();
    }
    update();
  }

  @override
  void handleChoosingDial(LecturesDialState chosenLecturesDial) {
    switch (chosenLecturesDial) {
      case LecturesDialState.editing:
        AppToasts.successToast("أختر محاضرة لتعديلها");
        break;
      case LecturesDialState.sharing:
        if (lecturesDialState == chosenLecturesDial &&
            dialChosenIndexes.isNotEmpty) {
          shareLectureDial();
        } else {
          AppToasts.successToast("أختر المحاضرات لمشاركتها");
        }
        break;
      case LecturesDialState.deleting:
        if (lecturesDialState == chosenLecturesDial &&
            dialChosenIndexes.isNotEmpty) {
          deleteLectureDial();
        } else {
          AppToasts.successToast("أختر المحاضرات لحذفها");
        }
        break;
      default:
    }
    lecturesDialState = chosenLecturesDial;
    update();
  }

  @override
  void choosePR() {
    vi = false;
    pr = true;
    ex = false;
    handleLectureButtonState();
    update();
  }

  @override
  void chooseVI() {
    vi = true;
    pr = false;
    ex = false;
    handleLectureButtonState();
    update();
  }

  @override
  void chooseEX() {
    vi = false;
    pr = false;
    ex = true;
    handleLectureButtonState();
    update();
  }

  @override
  void countTotalPages(BuildContext context) async {
    if (currentLectures.isNotEmpty) {
      Widget widget = const SizedBox();
      int totalPages = 0;
      double percent = 0;
      Get.defaultDialog(
          title: "حساب عدد الصفحات",
          titleStyle:
              Theme.of(context).textTheme.headline1!.copyWith(fontSize: 20),
          onWillPop: () => Future.value(false),
          content: GetBuilder<LecturePageControllerimp>(
              builder: (controller) => Column(
                    children: [
                      LinearProgressIndicator(
                          value: percent,
                          backgroundColor: Theme.of(context).primaryColorLight),
                      SizedBox(
                        height: 0,
                        width: 0,
                        child: widget,
                      ),
                    ],
                  )),
          barrierDismissible: false);
      for (int i = 0; i < currentLectures.length; i++) {
        if (currentLectures[i].numberofPages! != 0) {
          totalPages += currentLectures[i].numberofPages!;
          percent = i / currentLectures.length;
        } else {
          log("Loading Document...");
          widget = SfPdfViewer.file(
            File(currentLectures[i].lecturepath),
            pageLayoutMode: PdfPageLayoutMode.single,
            onDocumentLoadFailed: (s) {
              log("Document Failed To Load");
              currentLectures[i].numberofPages = 1;
            },
            onDocumentLoaded: (details) {
              log("Document Loaded");
              totalPages +=
                  getNumberOfPages(details, context, i, showData: false);
              percent = i / currentLectures.length;
              widget = const SizedBox();
              update();
            },
          );
          await Future.delayed(const Duration(milliseconds: 1500));
          widget = const SizedBox();
          update();
        }
      }
      log("Number of pages === $totalPages");
      AppToasts.successToast("عدد الصفحات الكلي هو $totalPages");
      Get.back();
    } else {
      AppToasts.showErrorToast("لا يوجد محاضرات!!!");
    }
  }

  @override
  void handleLectureButtonState() {
    if (lecturesNames.isNotEmpty && (pr == true || vi == true || ex == true)) {
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
        currentLectures = lectures.where((lecture) {
          return lecture.oldid.contains(subjectname) &&
              lecture.lecturetype == "دورة";
        }).toList();
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
  void addToBookMark(int index) {
    int lectureIndex = currentIndexToLectures(index);
    lectures[lectureIndex].bookMarked = !lectures[lectureIndex].bookMarked;
    lecturesBox.putAt(lectureIndex, lectures[lectureIndex]);
    if (lectures[lectureIndex].bookMarked == true) {
      AppToasts.successToast('تمت إضافة المحاضرة إلى المحفوظات');
    } else {
      AppToasts.successToast('تم إزالة المحاضرة من المحفوظات');
    }
    update();
  }

  @override
  void deleteSubject(BuildContext context) async {
    SubjectsPageControllerimp subjectsController = Get.find();
    subjectsController.subjects.removeAt(subjectindex);
    await subjectsController.subjectsBox.deleteAt(subjectindex);
    subjectsController.numberOfSubjects--;
    await userDataBox.put(
        HiveKeys.subjectsNumber, subjectsController.numberOfSubjects);
    int lectureIndex = 0;
    for (int i = 0; i < currentLectures.length; i++) {
      lectureIndex = lectures
          .lastIndexWhere((lecture) => lecture.oldid.contains(subjectname));
      await File(lectures[lectureIndex].lecturepath).delete();
      lectures.removeAt(lectureIndex);
      await lecturesBox.deleteAt(lectureIndex);
      numberofLectures--;
    }
    await userDataBox.put(HiveKeys.lecturesNumber, numberofLectures);
    AppToasts.successToast('تم حذف المادة بنجاح');
    Get.offNamedUntil(AppRoutes.mainPageRoute, (route) => false);
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
  void deleteLecture(int index, {bool back = true}) async {
    SubjectsPageControllerimp subjectsPageControllerimp = Get.find();
    if (back) {
      Get.back();
    }
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
    if (back) {
      update();
    }
  }

  @override
  void clearCache() async {
    Directory cachDir = await getTemporaryDirectory();
    cachDir.deleteSync(recursive: true);
  }

  @override
  int getNumberOfPages(
      PdfDocumentLoadedDetails details, BuildContext context, int index,
      {bool showData = true}) {
    int lectureIndex = currentIndexToLectures(index);
    lectures[lectureIndex].numberofPages = details.document.pages.count;
    currentLectures[index].numberofPages = lectures[lectureIndex].numberofPages;
    lecturesBox.putAt(lectureIndex, lectures[lectureIndex]);

    if (showData) {
      Get.back();
      lectureDataDialog(context, index);
    }
    return details.document.pages.count;
  }

  @override
  onWillPopDetailes() {
    Get.back();
    return Future.value(true);
  }

  @override
  void handleLecturesTap(int index) {
    if (lecturesDialState == LecturesDialState.none) {
      openLecture(index);
    } else if (lecturesDialState == LecturesDialState.editing) {
      editLectureName(index);
    } else {
      if (dialChosenIndexes.indexWhere((listIndex) => listIndex == index) ==
          -1) {
        dialChosenIndexes.add(index);
        currentLectures[index].chosen = true;
      } else {
        dialChosenIndexes.remove(index);
        currentLectures[index].chosen = false;
      }
      update();
    }
  }

  @override
  void deleteLectureDial() {
    dialChosenIndexes.sort();
    dialChosenIndexes = dialChosenIndexes.reversed.toList();
    for (int i = 0; i < dialChosenIndexes.length; i++) {
      deleteLecture(dialChosenIndexes[i], back: false);
    }
    AppToasts.successToast("تم حذف المحاضرات بنجاح");
    dialChosenIndexes.clear();
    update();
  }

  @override
  void shareLectureDial() {
    dialChosenIndexes.sort();
    List<XFile> shareLecture = [];
    for (int i = 0; i < dialChosenIndexes.length; i++) {
      shareLecture
          .add(XFile(currentLectures[dialChosenIndexes[i]].lecturepath));
    }
    Share.shareXFiles(shareLecture);
  }

  @override
  void editLectureName(int index) {
    TextEditingController newNameController =
        TextEditingController(text: currentLectures[index].lecturename);
    Get.defaultDialog(
        titlePadding: const EdgeInsets.only(top: 8, bottom: 0),
        contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 13),
        title: 'تعديل',
        titleStyle: Get.textTheme.headline1,
        content: CustomTextField(
            hint: "أدخل الاسم الجديد هنا...",
            editingController: newNameController),
        cancel: DialogButton(
          text: "إلغاء",
          onPressed: () async {
            Get.back();
            await Future.delayed(const Duration(seconds: 1));
            newNameController.dispose();
          },
        ),
        confirm: DialogButton(
          text: "تأكيد",
          onPressed: () async {
            if (lectures.indexWhere((lecture) =>
                    lecture.lecturename == newNameController.text) ==
                -1) {
              Get.back();
              File lecture = File(currentLectures[index].lecturepath);
              String newPath =
                  "${lecture.path.replaceFirst(currentLectures[index].lecturename, newNameController.text)}.pdf";
              await lecture.rename(newPath);
              currentLectures[index].lecturename =
                  "${newNameController.text}.pdf";
              currentLectures[index].lecturepath = newPath;
              update();
              await Future.delayed(const Duration(seconds: 1));
              newNameController.dispose();
            } else {
              AppToasts.showErrorToast("هناك محاضرة أخرى بهذا الاسم");
            }
          },
        ));
  }

  @override
  Future<void> openLecture(int index) async {
    int lectureIndex = currentIndexToLectures(index);
    addtorecent(
        index, currentLectures, recentLectures, lectureIndex, audioPlay);
    audioPlay = true;
    if (timer != null) {
      timer!.cancel();
      minTimer!.cancel();
    }
    if (selectedViewer != 2) {
      Get.toNamed(AppRoutes.lectureViewRoute, arguments: {
        "lecture": currentLectures[index],
        "Index": currentIndexToLectures(index),
        "Where": 0,
        "viewer": selectedViewer
      });
    } else {
      await OpenFile.open(currentLectures[index].lecturepath);
      if (userDataBox.get(HiveKeys.studyTime) == null ||
          userDataBox.get(HiveKeys.studyTime) == 0) {
        time = 0;
      } else {
        time = userDataBox.get(HiveKeys.studyTime);
      }
      timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        time = time! + (1 / 3600);
      });
      minTimer = Timer.periodic(const Duration(minutes: 3), (timer) {
        userDataBox.put(HiveKeys.studyTime, time);
      });
    }
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
      for (int i = 0; i < currentLectures.length; i++) {
        currentLectures[i].chosen = false;
      }
    } else {
      dataState = DataState.empty;
    }

    update();
    super.onReady();
  }

  @override
  void onInit() {
    subjectindex = Get.arguments["subjectIndex"];
    subjectname = Get.arguments['subjectname'];
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
    selectedViewer = hiveNullCheck(HiveKeys.selectedViewer, 0);
    super.onInit();
  }

  @override
  void onClose() {
    filterEditController!.dispose();
    if (timer != null) {
      timer!.cancel();
      minTimer!.cancel();
    }

    audioHandler.stop();
    super.onClose();
  }
}
