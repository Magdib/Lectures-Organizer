import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../controller/FeaturePagesControllers/RecentLectureController.dart';
import '../../../controller/NormalUsePagesControllers/LectureViewController.dart';

Future<bool> exitRefreshRecent() {
  RecentLecturesControllerimp recentPageController = Get.find();
  LectureViewControllerImp controller = Get.find();
  Get.back(result: {
    recentPageController.updateTime(controller.recentIndex!),
    controller.openLastTime()
  });
  return Future.value(true);
}

Future<bool> exitLecture() {
  LectureViewControllerImp controller = Get.find();
  Get.back(result: {
    controller.openLastTime(),
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values)
  });
  return Future.value(true);
}
