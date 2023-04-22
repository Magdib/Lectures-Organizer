import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unversityapp/view/Widgets/shared/DialogButton.dart';

import '../../../../controller/NormalUsePagesControllers/SubjectsPageController.dart';

class SubjectEditButton extends StatelessWidget {
  const SubjectEditButton({
    Key? key,
    required this.index,
    required this.elementindex,
  }) : super(key: key);
  final int index;
  final int elementindex;
  @override
  Widget build(BuildContext context) {
    return GetBuilder<SubjectsPageControllerimp>(
      builder: (controller) => DialogButton(
          text: 'تعديل',
          onPressed: controller.subjectButtonState == true
              ? () => controller.editSubject(index, elementindex)
              : null),
    );
  }
}
