import 'package:flutter/material.dart';
import 'package:unversityapp/controller/MainPagesControllers/SettingsController.dart';
import 'package:unversityapp/view/Widgets/shared/DialogButton.dart';

import 'package:get/get.dart';

void nextYearDialog(BuildContext context, int currentYear) {
  SettingsControllerimp controller = Get.find();
  Get.defaultDialog(
      titleStyle: Theme.of(context).textTheme.headline1!.copyWith(fontSize: 25),
      title: 'هل أنت متأكد',
      middleTextStyle: Theme.of(context).textTheme.headline2,
      middleText: 'عند التأكيد سيتم زيادة السنة الحالية بمقدار سنة واحدة',
      cancel: DialogButton(
        text: "إالغاء الأمر",
        onPressed: () => Get.back(),
      ),
      confirm: DialogButton(
        text: "تأكيد",
        onPressed: () => controller.confirmChangeYear(),
      ));
}
