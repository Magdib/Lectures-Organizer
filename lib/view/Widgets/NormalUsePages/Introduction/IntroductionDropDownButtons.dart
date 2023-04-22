import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../controller/NormalUsePagesControllers/introductionController.dart';
import 'introductionDropDownButton.dart';

class IntroductionDropDownButtons extends GetView<IntroductionControllerimp> {
  const IntroductionDropDownButtons({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<IntroductionControllerimp>(
      builder: (controller) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IgnorePointer(
            ignoring: controller.ignorPointer,
            child: IntroductionDropDownButton(
              hintText: 'عدد السنوات',
              enabled: controller.isNumberOfYearsChoosen,
              items: controller.numberofYearsList,
              onChanged: (val) => controller.changeNumberOfYears(val!),
              value: controller.numberOfYearsItem,
            ),
          ),
          IntroductionDropDownButton(
            hintText: 'السنة الحالية',
            enabled: controller.isCurrentYearChoosen,
            items: controller.currentYearList,
            onChanged: (val) => controller.changeCurrentYear(val!),
            value: controller.currentYearItem,
          ),
        ],
      ),
    );
  }
}
