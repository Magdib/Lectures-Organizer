import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unversityapp/controller/settingsPagesController/ProfileController.dart';
import 'package:unversityapp/view/Widgets/MainPages/Settings/Profile/AddRemoveRow.dart';
import 'package:unversityapp/view/Widgets/shared/CustomButton.dart';
import 'package:unversityapp/view/Widgets/shared/CustomTextField.dart';

class SmartAverageData extends StatelessWidget {
  const SmartAverageData({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileControllerimp>(
      builder: (controller) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "المعدل الذكي:",
                style: Theme.of(context)
                    .textTheme
                    .headline2!
                    .copyWith(fontSize: 25),
              ),
              CustomButton(
                  text: "حفظ",
                  minWidth: 80,
                  height: 45,
                  fontSize: 16,
                  onPressed: controller.canSaveAV
                      ? () => controller.saveAverage()
                      : null)
            ],
          ),
          const SizedBox(
            height: 25,
          ),
          CustomTextField(
            hint: "أكتب المعدّل هنا...",
            maxchar: 5,
            keyboardType: TextInputType.number,
            onchange: (value) => controller.checkAverageSave(),
            editingController: controller.averageController,
          ),
          const SizedBox(
            height: 25,
          ),
          AddRemoveRow(
            title: "عدد المواد:     ",
            value: "${controller.numberOfSubjects}",
            addFunction: () => controller.addSubject(),
            removeFunction: () => controller.removeSubject(),
          ),
        ],
      ),
    );
  }
}
