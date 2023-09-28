import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../controller/NormalUsePagesControllers/LecturePageController.dart';
import '../subjectsPage/RadioButton.dart';

class LectureTypeColumn extends StatelessWidget {
  const LectureTypeColumn({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GetBuilder<LecturePageControllerimp>(
          builder: (controller) => RadioButton(
            text: "عملي",
            onChanged:
                controller.pr == false ? () => controller.choosePR() : null,
          ),
        ),
        GetBuilder<LecturePageControllerimp>(
          builder: (controller) => RadioButton(
            text: "نظري",
            onChanged:
                controller.vi == false ? () => controller.chooseVI() : null,
          ),
        ),
        GetBuilder<LecturePageControllerimp>(
          builder: (controller) => RadioButton(
            text: "دورة",
            onChanged:
                controller.ex == false ? () => controller.chooseEX() : null,
          ),
        ),
      ],
    );
  }
}
