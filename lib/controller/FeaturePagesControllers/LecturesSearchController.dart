import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:unversityapp/core/class/enums/DataState.dart';
import 'package:unversityapp/core/functions/GlobalFunctions/addToRecent.dart';
import 'package:unversityapp/core/functions/GlobalFunctions/getLectures.dart';
import 'package:unversityapp/model/HiveAdaptersModels/LecturesAdapter.dart';

import '../../core/Constant/HiveData/HiveKeysBoxes.dart';
import '../../core/Routes/routes.dart';

abstract class LectureSearchController extends GetxController {
  void openLecture(int index, String query);
  void filterLectures(String query);
}

class LectureSearchControllerimp extends LectureSearchController {
  late Box<LecturesPageModel> lecturesBox;
  late Box<LecturesPageModel> recentBox;
  Box userDataBox = Hive.box(HiveBoxes.userDataBox);
  List<LecturesPageModel> lectures = [];
  List<LecturesPageModel> filterdLectrues = [];
  List<LecturesPageModel> recentLectures = [];
  int lecturesIndex = 0;
  int where = 0;
  DataState dataState = DataState.loading;
  @override
  void filterLectures(String query) {
    filterdLectrues = lectures
        .where((element) => element.lecturename.contains(query))
        .toList();
    if (filterdLectrues.isEmpty) {
      dataState = DataState.empty;
    } else {
      dataState = DataState.notEmpty;
    }
  }

  @override
  void openLecture(int index, String query) {
    if (filterdLectrues.isNotEmpty) {
      lecturesIndex = lectures.indexWhere((lecture) =>
          lecture.lecturename.contains(filterdLectrues[index].lecturename));
    }
    if (query.isEmpty) {
      addtorecent(index, lectures, recentLectures, index);
      Get.toNamed(AppRoutes.lectureViewRoute,
          arguments: {"lecture": lectures[index], "Index": index, "Where": 3});
    } else {
      addtorecent(index, filterdLectrues, recentLectures, lecturesIndex);
      Get.toNamed(AppRoutes.lectureViewRoute, arguments: {
        "lecture": filterdLectrues[index],
        "Index": lecturesIndex,
        "Where": 3
      });
    }
  }

  @override
  void onReady() async {
    lectures.clear();
    recentLectures.clear();
    if (Hive.isBoxOpen(HiveBoxes.lecturesBox)) {
      lecturesBox = Hive.box(HiveBoxes.lecturesBox);
    } else {
      lecturesBox = await Hive.openBox(HiveBoxes.lecturesBox);
    }
    if (Hive.isBoxOpen(HiveBoxes.recentBox) == false) {
      recentBox = await Hive.openBox(HiveBoxes.recentBox);
    } else {
      recentBox = Hive.box(HiveBoxes.recentBox);
    }
    getLectures(userDataBox, lecturesBox, lectures);

    if (recentBox.isNotEmpty) {
      for (int i = 0; i < recentBox.length; i++) {
        recentLectures.add(recentBox.getAt(i)!);
      }
    }
    if (lectures.isEmpty) {
      dataState = DataState.empty;
    } else {
      dataState = DataState.notEmpty;
    }
    where = 1;
    update();
    super.onReady();
  }
}
