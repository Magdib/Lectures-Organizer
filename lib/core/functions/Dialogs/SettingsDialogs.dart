import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unversityapp/controller/MainPagesControllers/SettingsController.dart';
import 'package:unversityapp/core/Constant/static_data.dart';
import 'package:unversityapp/view/Widgets/NormalUsePages/subjectsPage/RadioButton.dart';

selectViewerDialog() {
  List<String> viewerTexts = [
    "المشغّل الأول (أفتراضي)",
    "المشغّل الثاني (أسرع)",
    "مشغّل خارجي (مستحسن)"
  ];
  return Get.defaultDialog(
      titlePadding: const EdgeInsets.only(top: 8, bottom: 0),
      contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 13),
      title: 'نوع المشغّل',
      titleStyle: Get.textTheme.headline1,
      content: GetBuilder<SettingsControllerimp>(
        builder: (controller) => SizedBox(
          height: 140,
          width: StaticData.deviceWidth,
          child: ListView.builder(
            itemCount: viewerTexts.length,
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (context, index) => RadioButton(
                text: viewerTexts[index],
                onChanged: controller.selectedViewer == index
                    ? null
                    : () => controller.changeViewer(index)),
          ),
        ),
      ));
}
