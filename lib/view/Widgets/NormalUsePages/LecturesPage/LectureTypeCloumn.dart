import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../controller/NormalUsePagesControllers/LecturePageController.dart';
import '../subjectsPage/RadioButton.dart';

class LectureTypeCloumn extends StatelessWidget {
  const LectureTypeCloumn({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GetBuilder<LecturePageControllerimp>(
          builder: (controller) => RadioButton(
            text: "عملي",
            onTermChanged:
                controller.pr == false ? () => controller.choosePR() : null,
          ),
        ),
        GetBuilder<LecturePageControllerimp>(
          builder: (controller) => RadioButton(
            text: "نظري",
            onTermChanged:
                controller.vi == false ? () => controller.chooseVI() : null,
          ),
        )
      ],
    );
  }
}
