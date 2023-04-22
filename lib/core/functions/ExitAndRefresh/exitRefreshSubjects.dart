import 'package:get/get.dart';

import '../../../controller/NormalUsePagesControllers/SubjectsPageController.dart';

Future<bool> exitRefreshSubjects() {
  SubjectsPageControllerimp subjectsPageController = Get.find();
  Get.back(result: {subjectsPageController.refreshData()});
  return Future.value(true);
}
