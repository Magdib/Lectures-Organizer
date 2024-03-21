import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:unversityapp/core/Constant/HiveData/HiveKeysBoxes.dart';
import 'package:unversityapp/core/Routes/routes.dart';
import 'package:unversityapp/core/class/enums/DataState.dart';
import 'package:unversityapp/core/functions/GlobalFunctions/getLectures.dart';
import 'package:unversityapp/model/HiveAdaptersModels/NormalUseModels/LecturesAdapter.dart';
import '../../core/functions/snackBars/ErrorSnackBar.dart';
import '../../core/functions/validation/TermStringToInt.dart';
import '../../model/HiveAdaptersModels/NormalUseModels/SubjectsAdapter.dart';

abstract class SubjectsPageController extends GetxController {
  void chooseFirstTerm();
  void chooseSecondTerm();
  void addSubject();
  void editSubject(int index, int elementIndex);
  void pageyearcontroll(int term);
  void editpageyearcontroll(int term, int index, int elementindex);
  onWillPop();
  void getListData();
  void handelSubjectButtonState();
  void filterList(String value);
  void filterTermFunction(String value);
  String termIntToString(int currentTerm);
  void editTermFunction(int term);
  void goToLecturesPage(int index);
  void deleteSubject(int index);
  void refreshData();
}

class SubjectsPageControllerimp extends SubjectsPageController {
  late Box<SubjectsPageModel> subjectsBox;
  late Box<LecturesPageModel> lecturesBox;
  Box userDataBox = Hive.box(HiveBoxes.userDataBox);
  late String pageyear;
  List<SubjectsPageModel> subjects = [];
  List<LecturesPageModel> lectures = [];
  List<SubjectsPageModel> currentYearSubjects = [];
  late String wisdomword;
  int random = Random().nextInt(10);
  late int numberOfSubjects;
  TextEditingController? subjectNameController;
  TextEditingController? editSubjectController;
  TextEditingController? filterListController;
  bool isFirstTerm = false;
  bool isSecondeTerm = false;
  bool subjectButtonState = false;
  double container1hieght = 100;
  int numberofLectures = 0;
  String termFilter = "كِلا الفصلين";
  late DataState dataState = DataState.loading;
  @override
  void addSubject() {
    if (isFirstTerm == true) {
      pageyearcontroll(1);
    } else {
      pageyearcontroll(2);
    }
    currentYearSubjects
        .sort((a, b) => a.subjectName!.compareTo(b.subjectName!));
    update();
  }

  @override
  editSubject(int index, int elementIndex) {
    if (isFirstTerm == true) {
      editpageyearcontroll(1, index, elementIndex);
    } else {
      editpageyearcontroll(2, index, elementIndex);
    }
    onWillPop();
    update();
  }

  @override
  void pageyearcontroll(int term) {
    if (subjects
        .where((element) => element.subjectName! == subjectNameController!.text)
        .isEmpty) {
      subjects.add(SubjectsPageModel(
        id: pageyear,
        subjectName: subjectNameController!.text,
        numberoflecture: numberofLectures,
        term: term,
      ));
      currentYearSubjects.add(SubjectsPageModel(
        id: pageyear,
        subjectName: subjectNameController!.text,
        numberoflecture: numberofLectures,
        term: term,
      ));
      if (currentYearSubjects.length == 1) {
        dataState = DataState.notEmpty;
      }
      numberOfSubjects = numberOfSubjects + 1;
      subjectsBox.add(subjects[subjects.length - 1]);
      userDataBox.put(HiveKeys.subjectsNumber, numberOfSubjects);
      onWillPop();
    } else {
      errorSnackBar('المادة موجودة سابقاً',
          "الرجاء إضافة مادة أخرى أو كتابة اسم المادة كاملاً في حالة تطابق الأسماء في البداية");
    }
  }

  @override
  void editpageyearcontroll(int term, int index, int elementindex) {
    if (subjects
            .where((subject) =>
                subject.subjectName! == editSubjectController!.text)
            .isEmpty ||
        subjects[elementindex].subjectName == editSubjectController!.text) {
      int lecturesNumber = currentYearSubjects[index].numberoflecture;
      int? lectureIndex;
      for (int i = 0; i < lectures.length; i++) {
        lectureIndex = lectures.lastIndexWhere((lecture) =>
            lecture.oldid == currentYearSubjects[index].subjectName!);
        if (lectureIndex >= 0) {
          lectures[lectureIndex].oldid = editSubjectController!.text;
          lecturesBox.putAt(lectureIndex, lectures[lectureIndex]);
        }
      }

      subjects.removeAt(elementindex);
      subjects.insert(
          elementindex,
          SubjectsPageModel(
            id: pageyear,
            subjectName: editSubjectController!.text,
            numberoflecture: lecturesNumber,
            term: term,
          ));
      currentYearSubjects.removeAt(index);
      currentYearSubjects.insert(
          index,
          SubjectsPageModel(
            id: pageyear,
            subjectName: editSubjectController!.text,
            numberoflecture: lecturesNumber,
            term: term,
          ));

      subjectsBox.putAt(elementindex, subjects[elementindex]);
    }
  }

  @override
  void chooseFirstTerm() {
    isFirstTerm = true;
    isSecondeTerm = false;
    handelSubjectButtonState();
    update();
  }

  @override
  void chooseSecondTerm() {
    isSecondeTerm = true;
    isFirstTerm = false;
    handelSubjectButtonState();
    update();
  }

  @override
  onWillPop() async {
    subjectButtonState = false;
    Get.back();
    await Future.delayed(const Duration(milliseconds: 500));
    subjectNameController!.clear();
    editSubjectController!.clear();
    update();
  }

  @override
  List<SubjectsPageModel> getListData() {
    List<SubjectsPageModel> currentYearList = subjects;
    return currentYearList;
  }

  @override
  void handelSubjectButtonState() {
    if ((subjectNameController!.text.length > 1 ||
            editSubjectController!.text.length > 1) &&
        (isFirstTerm == true || isSecondeTerm == true)) {
      subjectButtonState = true;
      update();
    } else {
      subjectButtonState = false;
      update();
    }
  }

  @override
  void filterList(String value) {
    List<SubjectsPageModel> result = [];
    int currentTerm = currentTermFunction(termFilter);
    if (value.isNotEmpty) {
      if (currentTerm != 0) {
        result = subjects
            .where((subject) =>
                subject.id!.contains(pageyear) &&
                subject.subjectName!.contains(value) &&
                subject.term == currentTerm)
            .toList();
      } else {
        result = subjects
            .where((subject) =>
                subject.id!.contains(pageyear) &&
                subject.subjectName!.contains(value))
            .toList();
      }
    } else {
      if (currentTerm != 0) {
        result = subjects
            .where((subject) =>
                subject.id!.contains(pageyear) && subject.term == currentTerm)
            .toList();
      } else {
        result = subjects
            .where((subject) => subject.id!.contains(pageyear))
            .toList();
      }
    }
    currentYearSubjects = result;
    update();
  }

  @override
  void filterTermFunction(String value) {
    termFilter = value;
    switch (termFilter) {
      case "كِلا الفصلين":
        currentYearSubjects = subjects
            .where((lecture) => lecture.id!.contains(pageyear))
            .toList();
        break;
      case "الفصل الأول":
        currentYearSubjects = subjects.where((subject) {
          return subject.id!.contains(pageyear) && subject.term == 1;
        }).toList();

        break;
      case "الفصل الثاني":
        currentYearSubjects = subjects.where((subject) {
          return subject.id!.contains(pageyear) && subject.term == 2;
        }).toList();

        break;
      default:
    }
    filterListController!.clear();
    currentYearSubjects
        .sort((a, b) => a.subjectName!.compareTo(b.subjectName!));
    update();
  }

  @override
  String termIntToString(int currentTerm) {
    return currentTerm == 1 ? "الفصل: الأول" : "الفصل: الثاني";
  }

  @override
  void editTermFunction(int term) {
    term == 1 ? isFirstTerm = true : isSecondeTerm = true;
  }

  @override
  void deleteSubject(int index) async {
    for (int i = 0; i < currentYearSubjects[index].numberoflecture; i++) {
      int lectureIndex = lectures.lastIndexWhere((lecture) =>
          lecture.oldid.contains(currentYearSubjects[index].subjectName!));
      File(lectures[lectureIndex].lecturepath).deleteSync();
      lectures.removeAt(lectureIndex);
      lecturesBox.deleteAt(lectureIndex);
    }
    int deleteindex = subjects.indexWhere((element) =>
        element.subjectName!.contains(currentYearSubjects[index].subjectName!));
    //Delete For Ui
    currentYearSubjects.removeAt(currentYearSubjects.indexWhere((element) =>
        element.subjectName!
            .contains(currentYearSubjects[index].subjectName!)));
    //Real Delete
    subjects.removeAt(deleteindex);
    numberOfSubjects = numberOfSubjects - 1;
    subjectsBox.deleteAt(deleteindex);
    userDataBox.put(HiveKeys.subjectsNumber, numberOfSubjects);
    if (currentYearSubjects.isEmpty) {
      dataState = DataState.empty;
    }

    Get.back();
    update();
  }

  @override
  void goToLecturesPage(int index) {
    Get.toNamed(AppRoutes.lecturesPageRoute, arguments: {
      'subjectname': currentYearSubjects[index].subjectName,
      "subjectIndex": subjects.indexWhere((subject) =>
          subject.subjectName == currentYearSubjects[index].subjectName)
    });
  }

  @override
  void refreshData() {
    subjects.clear();
    if (numberOfSubjects > 0) {
      for (int i = 0; i < numberOfSubjects; i++) {
        subjects.add(subjectsBox.getAt(i)!);
      }
    }
    if (subjects.isNotEmpty) {
      currentYearSubjects =
          subjects.where((subject) => subject.id!.contains(pageyear)).toList();
      if (currentYearSubjects.isNotEmpty) {
        dataState = DataState.notEmpty;
      } else {
        dataState = DataState.empty;
      }
    }

    lectures.clear();
    getLectures(userDataBox, lecturesBox, lectures);
    currentYearSubjects
        .sort((a, b) => a.subjectName!.compareTo(b.subjectName!));
    update();
  }

  handleUpdate() async {
    if (userDataBox.get(HiveKeys.appVersion) == null) {
      for (int i = 0; i < lecturesBox.length; i++) {
        lecturesBox.putAt(
            i,
            LecturesPageModel(
                check: lecturesBox.getAt(i)!.check,
                oldid: lecturesBox.getAt(i)!.oldid,
                lecturepath: lecturesBox.getAt(i)!.lecturepath,
                lecturename: lecturesBox.getAt(i)!.lecturename,
                lecturetype: lecturesBox.getAt(i)!.lecturetype,
                time: lecturesBox.getAt(i)!.time,
                bookMarked: lecturesBox.getAt(i)!.bookMarked,
                offset: lecturesBox.getAt(i)!.offset,
                numberofPages: lecturesBox.getAt(i)!.numberofPages));
      }
      userDataBox.put(HiveKeys.appVersion, "1.2");
    }
  }

  @override
  void onReady() async {
    subjectsBox = await Hive.openBox(HiveBoxes.subjectsBox);
    lecturesBox = await Hive.openBox(HiveBoxes.lecturesBox);
    await handleUpdate();

    refreshData();
    super.onReady();
  }

  @override
  void onInit() {
    pageyear = Get.arguments['year'];
    filterListController = TextEditingController();
    editSubjectController = TextEditingController();
    subjectNameController = TextEditingController();
    if (userDataBox.get(HiveKeys.subjectsNumber) != null &&
        userDataBox.get(HiveKeys.subjectsNumber) != 0) {
      dataState = DataState.loading;
      numberOfSubjects = userDataBox.get(HiveKeys.subjectsNumber);
    } else {
      dataState = DataState.empty;
      numberOfSubjects = 0;
    }
    super.onInit();
  }

  @override
  void onClose() {
    filterListController!.dispose();
    editSubjectController!.dispose();
    subjectNameController!.dispose();
    super.onClose();
  }
}
