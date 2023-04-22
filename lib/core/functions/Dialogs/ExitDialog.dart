import 'dart:io';

import 'package:get/get.dart';
import 'package:unversityapp/view/Widgets/shared/DialogButton.dart';

Future<bool> exitDialog() {
  Get.defaultDialog(
      titleStyle: Get.textTheme.headline1,
      title: 'خروج من التطبيق',
      middleTextStyle: Get.textTheme.headline2,
      middleText: 'هل أنت متأكد أنك تريد الخروج من التطبيق',
      cancel: DialogButton(text: "إلغاء الأمر", onPressed: () => Get.back()),
      confirm: DialogButton(
        text: "تأكيد",
        onPressed: () => exit(0),
      ));
  return Future.value(true);
}
