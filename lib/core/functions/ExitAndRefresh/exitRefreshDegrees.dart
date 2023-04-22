import 'package:get/get.dart';

import '../../../controller/MainPagesControllers/SettingsController.dart';

Future<bool> exitRefreshDegrees() {
  SettingsControllerimp settingsController = Get.find();
  Get.back(result: {settingsController.getAverage(1)});
  return Future.value(true);
}
