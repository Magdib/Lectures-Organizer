import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:unversityapp/core/class/enums/DataState.dart';
import 'package:unversityapp/core/functions/GlobalFunctions/addToRecent.dart';
import 'package:unversityapp/model/HiveAdaptersModels/LecturesAdapter.dart';

import '../../core/Constant/HiveData/HiveKeysBoxes.dart';
import '../../core/Routes/routes.dart';
import '../../core/functions/GlobalFunctions/getLectures.dart';

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
  void openLecture(int index) {
    int lectureIndex = lectures.indexWhere((lecture) =>
        lecture.lecturename.contains(bookMarkedLectures[index].lecturename));
    addtorecent(index, bookMarkedLectures, recentLectures, lectureIndex);
    Get.toNamed(AppRoutes.lectureViewRoute, arguments: {
      "lecture": bookMarkedLectures[index],
      "Index": lectureIndex,
      "Where": 1
    });
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

    super.onReady();
  }
}
