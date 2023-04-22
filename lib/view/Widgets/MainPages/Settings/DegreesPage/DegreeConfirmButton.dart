import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unversityapp/controller/settingsPagesController/degreesPageController.dart';
import '../../../shared/DialogButton.dart';

class DegreeConfirmButton extends StatelessWidget {
  const DegreeConfirmButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DegreesControllerimp>(
      builder: (controller) => DialogButton(
          text: 'إضافة',
          onPressed: controller.buttonState == true
              ? () => controller.addDegree()
              : null),
    );
  }
}
