import 'dart:async';

import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:open_file/open_file.dart';
import 'package:unversityapp/core/Constant/HiveData/HiveKeysBoxes.dart';
import 'package:unversityapp/core/Routes/routes.dart';
import 'package:unversityapp/core/class/enums/DataState.dart';
import 'package:unversityapp/core/functions/GlobalFunctions/hiveNullCheck.dart';
import 'package:unversityapp/model/HiveAdaptersModels/NormalUseModels/LecturesAdapter.dart';
import 'package:unversityapp/model/HiveAdaptersModels/NormalUseModels/SubjectsAdapter.dart';
import 'package:unversityapp/core/services/Services.dart';

abstract class FastModeController extends GetxController {
  chooseSubject(int index);

  List<LecturesPageModel> lectureToCurrent();
  int currentIndexToLectures(int index);
  getLectures();
  completeLecture(int index);
  openLecture(int index);
  exitFastMode();
  void changeMusicState();
}

class FastModeControllerimp extends FastModeController {
  Box userDataBox = Hive.box(HiveBoxes.userDataBox);
  late Box<LecturesPageModel> lecturesBox;
  late Box<SubjectsPageModel> subjectsBox;
  List<SubjectsPageModel> subjects = [];
  List<LecturesPageModel> lectures = [];
  late List<LecturesPageModel> currentLectures = [];
  DataState dataState = DataState.loading;
  String? subjectName;
  int? selectedViewer;
  Timer? timer;
  Timer? minTimer;
  double? time;
  bool activeMusic = false;
  bool audioPlay = false;
  @override
  chooseSubject(int index) async {
    await userDataBox.put(HiveKeys.fastSubject, subjects[index].subjectName);
    subjectName = subjects[index].subjectName!;
    await userDataBox.put(HiveKeys.step, 2);
    Get.offAllNamed(AppRoutes.fastModePageRoute);

    selectedViewer ??= hiveNullCheck(HiveKeys.selectedViewer, 0);
    await getLectures();
  }

  @override
  List<LecturesPageModel> lectureToCurrent() {
    List<LecturesPageModel> currentList;
    currentList =
        lectures.where((lecture) => lecture.oldid == subjectName).toList();
    return currentList;
  }

  @override
  int currentIndexToLectures(int index) {
    return lectures.indexWhere((lecture) =>
        lecture.lecturename.contains(currentLectures[index].lecturename));
  }

  @override
  getLectures() async {
    lectures.clear();
    currentLectures.clear();
    subjectName = await userDataBox.get(HiveKeys.fastSubject);
    lecturesBox = await Hive.openBox(HiveBoxes.lecturesBox);
    if (lecturesBox.isNotEmpty) {
      lectures.addAll(lecturesBox.values);
      currentLectures = lectureToCurrent();
      dataState = DataState.notEmpty;
    } else {
      dataState = DataState.empty;
    }
    update();
  }

  @override
  void completeLecture(int index) {
    int lectureIndex = currentIndexToLectures(index);
    lectures[lectureIndex].check = !lectures[lectureIndex].check;
    lecturesBox.putAt(lectureIndex, lectures[lectureIndex]);
    update();
  }

  @override
  void changeMusicState() {
    audioPlay = false;
    activeMusic = !activeMusic;
    userDataBox.put(HiveKeys.activeMusic, activeMusic);
    update();
  }

  @override
  openLecture(int index) async {
    if (timer != null) {
      timer!.cancel();
      minTimer!.cancel();
    }
    if (selectedViewer != 2) {
      Get.toNamed(AppRoutes.lectureViewRoute, arguments: {
        "lecture": currentLectures[index],
        "Index": currentIndexToLectures(index),
        "Where": 4,
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
    if (audioPlay == false && activeMusic) {
      await audioHandler.play();
    }
    audioPlay = true;
  }

  @override
  exitFastMode() async {
    await userDataBox.put(HiveKeys.step, 1);
    await Get.offAllNamed(AppRoutes.mainPageRoute);
    await Get.delete<FastModeControllerimp>();
  }

  updateMethod() {
    update();
  }

  @override
  void onReady() async {
    selectedViewer ??= hiveNullCheck(HiveKeys.selectedViewer, 0);
    activeMusic = hiveNullCheck(HiveKeys.activeMusic, false);

    if (Get.previousRoute == AppRoutes.advancedFeaturePage) {
      subjectsBox = await Hive.openBox(HiveBoxes.subjectsBox);
      if (subjectsBox.isNotEmpty) {
        subjects.addAll(subjectsBox.values);
        dataState = DataState.notEmpty;
      } else {
        dataState = DataState.empty;
      }
      update();
    } else {
      await getLectures();
    }

    super.onReady();
  }
}
