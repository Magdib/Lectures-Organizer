import 'package:get/get.dart';

import '../../../controller/NormalUsePagesControllers/LecturePageController.dart';
import '../../../controller/NormalUsePagesControllers/LectureViewController.dart';

Future<bool> exitRefreshLecture() {
  LecturePageControllerimp lecturePageController = Get.find();
  LectureViewControllerImp controller = Get.find();
  Get.back(result: {
    lecturePageController.refreshData(1),
    controller.openLastTime()
  });
  return Future.value(true);
}
