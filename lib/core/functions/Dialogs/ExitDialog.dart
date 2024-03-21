import 'dart:io';

import 'package:get/get.dart';
import 'package:unversityapp/controller/settingsPagesController/advancedfeaturescontrollers/create_exam_controller.dart';
import 'package:unversityapp/view/Widgets/shared/DialogButton.dart';

Future<bool> exitAppDialog() {
  Get.defaultDialog(
      titleStyle: Get.textTheme.headline1,
      title: 'خروج من التطبيق',
      middleTextStyle: Get.textTheme.headline2,
      middleText: 'هل أنت متأكد أنك تريد الخروج من التطبيق',
      cancel: DialogButton(text: "إلغاء الأمر", onPressed: () => Get.back()),
      confirm: DialogButton(
        text: "تأكيد",
        onPressed: () {
          exit(0);
        },
      ));
  return Future.value(true);
}

stopBackDialog() {
  CreateExamController controller = Get.find();
  Get.defaultDialog(
      titleStyle: Get.textTheme.headline1,
      title: 'خروج من التصميم؟',
      middleTextStyle: Get.textTheme.headline2,
      middleText:
          'هل أنت متأكد أنك تريد الخروج من تصميم الأختبار سيتم حذف جميع بيانات هذا الأختبار',
      cancel: DialogButton(text: "إلغاء الأمر", onPressed: () => Get.back()),
      confirm: DialogButton(
        text: "تأكيد",
        onPressed: () => controller.allowPop(),
      ));
}
