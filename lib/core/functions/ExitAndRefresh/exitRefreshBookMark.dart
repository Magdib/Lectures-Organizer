import 'package:get/get.dart';
import 'package:unversityapp/controller/FeaturePagesControllers/BookMarkController.dart';

import '../../../controller/NormalUsePagesControllers/LectureViewController.dart';

Future<bool> exitRefreshBookMark() {
  BookMarkControllerimp bookMarkController = Get.find();
  LectureViewControllerImp controller = Get.find();
  Get.back(
      result: {bookMarkController.refreshData(), controller.openLastTime()});
  return Future.value(true);
}
