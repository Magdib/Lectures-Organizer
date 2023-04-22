import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unversityapp/view/Widgets/shared/DialogButton.dart';

import '../../../../controller/NormalUsePagesControllers/SubjectsPageController.dart';

class SubjectConfirmButton extends StatelessWidget {
  const SubjectConfirmButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SubjectsPageControllerimp>(
      builder: (controller) => DialogButton(
          text: 'إضافة',
          onPressed: controller.subjectButtonState == true
              ? () => controller.addSubject()
              : null),
    );
  }
}
