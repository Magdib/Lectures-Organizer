import 'dart:async';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:open_file/open_file.dart';
import 'package:unversityapp/core/Constant/HiveData/HiveKeysBoxes.dart';
import 'package:hive/hive.dart';
import 'package:unversityapp/core/class/enums/DataState.dart';
import 'package:unversityapp/core/functions/GlobalFunctions/hiveNullCheck.dart';
import 'package:unversityapp/core/services/Services.dart';

import '../../core/Routes/routes.dart';
import '../../model/HiveAdaptersModels/NormalUseModels/LecturesAdapter.dart';

abstract class RecentLecturesController extends GetxController {
  void openLecture(int index);
  void updateTime(int index);
}

class RecentLecturesControllerimp extends RecentLecturesController {
  List<LecturesPageModel> recentLectures = [];
  late Box<LecturesPageModel> recentBox;
  Box userDataBox = Hive.box(HiveBoxes.userDataBox);
  DataState dataState = DataState.loading;
  late int selectedViewer;
  Timer? timer;
  Timer? minTimer;
  double? time;
  bool audioPlay = false;
  @override
  Future<void> openLecture(int index) async {
    if (timer != null) {
      timer!.cancel();
      minTimer!.cancel();
    }
    if (selectedViewer != 2) {
      Get.toNamed(AppRoutes.lectureViewRoute, arguments: {
        "lecture": recentLectures[index],
        "Index": userDataBox.get(index),
        "Where": 2,
        "RecentIndex": index,
        "viewer": selectedViewer
      });
    } else {
      await OpenFile.open(recentLectures[index].lecturepath);
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
    bool activeMusic = hiveNullCheck(HiveKeys.activeMusic, false);
    if (audioPlay == false && activeMusic) {
      await audioHandler.play();
    }
    audioPlay = true;
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
      await Hive.openBox<LecturesPageModel>(HiveBoxes.lecturesBox);
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
    selectedViewer = hiveNullCheck(HiveKeys.selectedViewer, 0);
    update();
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
