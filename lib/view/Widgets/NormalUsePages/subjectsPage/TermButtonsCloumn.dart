import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../controller/NormalUsePagesControllers/SubjectsPageController.dart';
import 'RadioButton.dart';

class RadioButtonsCloumn extends StatelessWidget {
  const RadioButtonsCloumn({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GetBuilder<SubjectsPageControllerimp>(
          builder: (controller) => RadioButton(
            text: 'الفصل الأول',
            onTermChanged: controller.isFirstTerm == false
                ? () => controller.chooseFirstTerm()
                : null,
          ),
        ),
        GetBuilder<SubjectsPageControllerimp>(
          builder: (controller) => RadioButton(
            text: " الفصل الثاني",
            onTermChanged: controller.isSecondeTerm == false
                ? () => controller.chooseSecondTerm()
                : null,
          ),
        )
      ],
    );
  }
}
