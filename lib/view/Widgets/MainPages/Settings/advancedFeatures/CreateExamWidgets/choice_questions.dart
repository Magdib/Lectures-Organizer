import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unversityapp/controller/settingsPagesController/advancedfeaturescontrollers/create_exam_controller.dart';
import 'package:unversityapp/core/Constant/static_data.dart';
import 'package:unversityapp/view/Widgets/MainPages/Settings/GreyDivider.dart';
import 'package:unversityapp/view/Widgets/shared/CustomTextField.dart';

class ChoiceQuestions extends StatelessWidget {
  const ChoiceQuestions({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CreateExamController>(
      builder: (controller) => ListView.separated(
        itemCount: controller.choiceQuestions.length,
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
                  controller.onChangeQuestionText(index, false, val),
              borderRadius: 10,
              prefixIcon: Icons.keyboard_voice,
              onPressedPrefix: () =>
                  controller.listenToQuestion(index, false, context),
              suffixIcon: Icons.delete_forever_outlined,
              onPressedSuffix: () => controller.deleteQuestion(index, false),
            ),
            const SizedBox(
              height: 20,
            ),
            GetBuilder<CreateExamController>(
              builder: (controller) => GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, childAspectRatio: 2),
                itemCount: controller.choiceQuestions[index].choices.length < 4
                    ? controller.choiceQuestions[index].choices.length + 1
                    : 4,
                itemBuilder: (context, gridIndex) => gridIndex <
                        controller.choiceQuestions[index].choices.length
                    ? InkWell(
                        onTap: controller.choiceQuestions[index].correctIndex ==
                                gridIndex
                            ? () =>
                                controller.chooseRightQuestion(index, gridIndex)
                            : null,
                        child: CustomTextField(
                          hint: "أدخل الخيار هنا...",
                          label: controller
                              .choiceQuestions[index].choiceLetter[gridIndex],
                          suffixIcon:
                              gridIndex > 1 ? Icons.delete_outline : null,
                          readOnly:
                              controller.choiceQuestions[index].correctIndex ==
                                  gridIndex,
                          onchange: (val) => controller.onChangedAnswerText(
                              index, gridIndex, val),
                          onPressedSuffix: () =>
                              controller.deleteChoice(index, gridIndex),
                          prefixIcon:
                              controller.choiceQuestions[index].correctIndex !=
                                      gridIndex
                                  ? Icons.check_box_outlined
                                  : null,
                          onPressedPrefix: () =>
                              controller.chooseRightQuestion(index, gridIndex),
                        ),
                      )
                    : IconButton(
                        onPressed: () => controller.addChoiceQuestion(index),
                        icon: const Icon(
                          Icons.add_circle_outline,
                          size: 40,
                        )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
