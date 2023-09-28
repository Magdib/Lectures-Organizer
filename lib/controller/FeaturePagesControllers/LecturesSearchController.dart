import 'dart:async';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:open_file/open_file.dart';
import 'package:unversityapp/core/class/enums/DataState.dart';
import 'package:unversityapp/core/functions/GlobalFunctions/addToRecent.dart';
import 'package:unversityapp/core/functions/GlobalFunctions/getLectures.dart';
import 'package:unversityapp/core/functions/GlobalFunctions/hiveNullCheck.dart';
import 'package:unversityapp/core/services/Services.dart';
import 'package:unversityapp/model/HiveAdaptersModels/LecturesAdapter.dart';

import '../../core/Constant/HiveData/HiveKeysBoxes.dart';
import '../../core/Routes/routes.dart';

abstract class LectureSearchController extends GetxController {
  void openLecture(int index, String query);
  void filterLectures(String query);
  void handleViewer(int index, bool emptyquery);
  willPopSearch();
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
  late int selectedViewer;
  Timer? timer;
  Timer? minTimer;
  double? time;
  bool audioPlay = false;
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
  void openLecture(int index, String query) async {
    if (filterdLectrues.isNotEmpty) {
      lecturesIndex = lectures.indexWhere((lecture) =>
          lecture.lecturename.contains(filterdLectrues[index].lecturename));
    }
    if (query.isEmpty) {
      addtorecent(index, lectures, recentLectures, index, audioPlay);
      audioPlay = true;
      handleViewer(index, true);
    } else {
      addtorecent(
          index, filterdLectrues, recentLectures, lecturesIndex, audioPlay);
      audioPlay = true;
      handleViewer(index, false);
    }
  }

  @override
  void handleViewer(int index, bool emptyquery) async {
    if (timer != null) {
      timer!.cancel();
      minTimer!.cancel();
    }
    if (selectedViewer != 2) {
      if (emptyquery) {
        Get.toNamed(AppRoutes.lectureViewRoute, arguments: {
          "lecture": lectures[index],
          "Index": index,
          "Where": 3,
          "viewer": selectedViewer
        });
      } else {
        Get.toNamed(AppRoutes.lectureViewRoute, arguments: {
          "lecture": filterdLectrues[index],
          "Index": lecturesIndex,
          "Where": 3,
          "viewer": selectedViewer
        });
      }
    } else {
      emptyquery
          ? await OpenFile.open(lectures[index].lecturepath)
          : await OpenFile.open(filterdLectrues[index].lecturepath);
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
    selectedViewer = hiveNullCheck(HiveKeys.selectedViewer, 0);

    update();
    super.onReady();
  }

  @override
  willPopSearch() {
    Get.back();
    if (timer != null) {
      timer!.cancel();
      minTimer!.cancel();
    }
    audioPlay = false;
    audioHandler.stop();
    return Future.value(false);
  }
}
