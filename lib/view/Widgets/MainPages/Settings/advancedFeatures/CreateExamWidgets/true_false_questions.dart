import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unversityapp/controller/settingsPagesController/advancedfeaturescontrollers/create_exam_controller.dart';
import 'package:unversityapp/core/Constant/static_data.dart';
import 'package:unversityapp/view/Widgets/MainPages/Settings/GreyDivider.dart';
import 'package:unversityapp/view/Widgets/NormalUsePages/subjectsPage/RadioButton.dart';
import 'package:unversityapp/view/Widgets/shared/CustomTextField.dart';

class TrueFalseQuestions extends StatelessWidget {
  const TrueFalseQuestions({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CreateExamController>(
      builder: (controller) => ListView.separated(
        itemCount: controller.trueFalseQuestions.length,
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        separatorBuilder: (context, index) => const Column(
          children: [
            GreyDivider(),
            SizedBox(
              height: 10,
            ),
          ],
        ),
        itemBuilder: (context, index) => Column(
          children: [
            CustomTextField(
              label: "نص السؤال:",
              hint: "أدخل نص السؤال هنا...",
              maxchar: StaticData.questionMaxChar,
              onchange: (val) =>
                  controller.onChangeQuestionText(index, true, val),
              borderRadius: 10,
              prefixIcon: Icons.keyboard_voice,
              onPressedPrefix: () =>
                  controller.listenToQuestion(index, true, context),
              editingController: TextEditingController(
                  text: controller.trueFalseQuestions[index].question),
              suffixIcon: Icons.delete_forever_outlined,
              onPressedSuffix: () => controller.deleteQuestion(index, true),
            ),
            const SizedBox(
              height: 10,
            ),
            GetBuilder<CreateExamController>(
              builder: (controller) => Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  RadioButton(
                      text: "صح",
                      onChanged:
                          controller.trueFalseQuestions[index].answer != true
                              ? () => controller.setTrueFalseAnswer(true, index)
                              : null),
                  RadioButton(
                      text: "خطأ",
                      onChanged: controller.trueFalseQuestions[index].answer !=
                              false
                          ? () => controller.setTrueFalseAnswer(false, index)
                          : null),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
