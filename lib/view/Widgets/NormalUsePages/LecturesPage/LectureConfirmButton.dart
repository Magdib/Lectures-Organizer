import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../controller/NormalUsePagesControllers/LecturePageController.dart';
import '../../shared/DialogButton.dart';

class LectureConfirmButton extends StatelessWidget {
  const LectureConfirmButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LecturePageControllerimp>(
      builder: (controller) => DialogButton(
          text: 'إضافة',
          onPressed: controller.lectureButtonState == true
              ? () => controller.addLecture()
              : null),
    );
  }
}
