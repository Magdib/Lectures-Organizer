import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unversityapp/controller/settingsPagesController/degreesPageController.dart';
import 'package:unversityapp/view/Widgets/shared/DialogButton.dart';

import '../../../view/Widgets/MainPages/Settings/DegreesPage/DegreeConfirmButton.dart';
import '../../../view/Widgets/shared/TextFormField.dart';

void degreesDialog(BuildContext context) {
  DegreesControllerimp controller = Get.find();
  Get.defaultDialog(
      title: "إضافة درجة مادة",
      titleStyle: Theme.of(context).textTheme.headline1,
      barrierDismissible: false,
      content: Column(
        children: [
          CustomTextField(
              hint: 'أدخل اسم المادة هنا',
              editingController: controller.degreeTextController!,
              onchange: (val) => controller.handleButtonState(val),
              maxchar: 30),
          GetBuilder<DegreesControllerimp>(
            builder: (controller) => Column(
              children: [
                Slider(
                  value: controller.degree,
                  min: 0,
                  max: 100,
                  label: "${controller.degree}",
                  onChanged: (val) => controller.chooseDegree(val),
                ),
                Text(
                  "${controller.degree.round()}",
                  style: Theme.of(context)
                      .textTheme
                      .headline1!
                      .copyWith(fontSize: 15),
                )
              ],
            ),
          )
        ],
      ),
      confirm: const DegreeConfirmButton(),
      cancel: DialogButton(
        text: "إلغاء الأمر",
        onPressed: () => controller.onWillPop(),
      ));
}
