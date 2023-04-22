import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:unversityapp/core/Constant/HiveData/HiveKeysBoxes.dart';
import 'package:hive/hive.dart';
import 'package:unversityapp/core/class/enums/DataState.dart';

import '../../core/Routes/routes.dart';
import '../../model/HiveAdaptersModels/LecturesAdapter.dart';

abstract class RecentLecturesController extends GetxController {
  void openLecture(int index);
  void updateTime(int index);
}

class RecentLecturesControllerimp extends RecentLecturesController {
  List<LecturesPageModel> recentLectures = [];
  late Box<LecturesPageModel> recentBox;
  Box userDataBox = Hive.box(HiveBoxes.userDataBox);
  DataState dataState = DataState.loading;
  @override
  void openLecture(int index) {
    Get.toNamed(AppRoutes.lectureViewRoute, arguments: {
      "lecture": recentLectures[index],
      "Index": userDataBox.get(index),
      "Where": 2,
      "RecentIndex": index
    });
  }

  @override
  void updateTime(int index) {
    recentLectures[index].time = DateTime.now().toString();
    recentBox.putAt(index, recentLectures[index]);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);

    update();
  }

  @override
  void onReady() async {
    if (Hive.isBoxOpen(HiveBoxes.recentBox)) {
      recentBox = Hive.box(HiveBoxes.recentBox);
    } else {
      recentBox = await Hive.openBox(HiveBoxes.recentBox);
    }
    if (Hive.isBoxOpen(HiveBoxes.lecturesBox) == false) {
      Box<LecturesPageModel> s = await Hive.openBox(HiveBoxes.lecturesBox);
    }
    if (recentBox.isNotEmpty) {
      for (int i = 0; i < recentBox.length; i++) {
        recentLectures.add(recentBox.getAt(i)!);
      }
    }
    //Make Global In Future;
    if (recentLectures.isNotEmpty) {
      dataState = DataState.notEmpty;
    } else {
      dataState = DataState.empty;
    }
    update();
    super.onReady();
  }
}
