import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:unversityapp/core/class/enums/DataState.dart';
import 'package:unversityapp/core/functions/GlobalFunctions/addToRecent.dart';
import 'package:unversityapp/core/functions/GlobalFunctions/hiveNullCheck.dart';
import 'package:unversityapp/core/services/Services.dart';
import 'package:unversityapp/model/HiveAdaptersModels/NormalUseModels/LecturesAdapter.dart';
import 'dart:async';
import '../../core/Constant/HiveData/HiveKeysBoxes.dart';
import '../../core/Routes/routes.dart';
import '../../core/functions/GlobalFunctions/getLectures.dart';
import 'package:open_file/open_file.dart';

abstract class BookMarkController extends GetxController {
  void removeLecture(int index);
  void openLecture(int index);
  void refreshData();
}

class BookMarkControllerimp extends BookMarkController {
  Box userDataBox = Hive.box(HiveBoxes.userDataBox);
  late Box<LecturesPageModel> lecturesBox;
  List<LecturesPageModel> lectures = [];
  List<LecturesPageModel> bookMarkedLectures = [];
  List<LecturesPageModel> recentLectures = [];
  late Box<LecturesPageModel> recentBox;
  DataState dataState = DataState.loading;
  late int selectedViewer;
  Timer? timer;
  Timer? minTimer;
  double? time;
  bool audioPlay = false;
  @override
  void removeLecture(int index) {
    int lectureIndex = lectures.indexWhere((lecture) =>
        lecture.lecturename.contains(bookMarkedLectures[index].lecturename));
    lectures[lectureIndex].bookMarked = false;
    lecturesBox.putAt(lectureIndex, lectures[lectureIndex]);
    bookMarkedLectures =
        lectures.where((lecture) => lecture.bookMarked == true).toList();
    if (bookMarkedLectures.isEmpty) {
      dataState = DataState.empty;
    }
    update();
  }

  @override
  Future<void> openLecture(int index) async {
    int lectureIndex = lectures.indexWhere((lecture) =>
        lecture.lecturename.contains(bookMarkedLectures[index].lecturename));
    addtorecent(
        index, bookMarkedLectures, recentLectures, lectureIndex, audioPlay);
    audioPlay = true;
    if (timer != null) {
      timer!.cancel();
      minTimer!.cancel();
    }
    if (selectedViewer != 2) {
      Get.toNamed(AppRoutes.lectureViewRoute, arguments: {
        "lecture": bookMarkedLectures[index],
        "Index": lectureIndex,
        "Where": 1,
        "viewer": selectedViewer
      });
    } else {
      await OpenFile.open(bookMarkedLectures[index].lecturepath);
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
  void refreshData() {
    lectures.clear();
    getLectures(userDataBox, lecturesBox, lectures);
    bookMarkedLectures =
        lectures.where((lecture) => lecture.bookMarked == true).toList();
    if (bookMarkedLectures.isEmpty) {
      dataState = DataState.empty;
    } else {
      dataState = DataState.notEmpty;
    }
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
    update();
  }

  @override
  void onReady() async {
    if (Hive.isBoxOpen(HiveBoxes.lecturesBox) == false) {
      lecturesBox = await Hive.openBox(HiveBoxes.lecturesBox);
    } else {
      lecturesBox = Hive.box(HiveBoxes.lecturesBox);
    }
    if (Hive.isBoxOpen(HiveBoxes.recentBox) == false) {
      recentBox = await Hive.openBox(HiveBoxes.recentBox);
    } else {
      recentBox = Hive.box(HiveBoxes.recentBox);
    }
    refreshData();
    if (recentBox.isNotEmpty) {
      for (int i = 0; i < recentBox.length; i++) {
        recentLectures.add(recentBox.getAt(i)!);
      }
    }

    selectedViewer = hiveNullCheck(HiveKeys.selectedViewer, 0);
    super.onReady();
  }

  @override
  void onClose() {
    if (timer != null) {
      timer!.cancel();
      minTimer!.cancel();
    }
    audioHandler.stop();
    super.onClose();
  }
}
