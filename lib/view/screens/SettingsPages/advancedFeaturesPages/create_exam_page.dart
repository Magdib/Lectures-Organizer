import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unversityapp/controller/settingsPagesController/advancedfeaturescontrollers/create_exam_controller.dart';
import 'package:unversityapp/core/Constant/static_data.dart';
import 'package:unversityapp/core/functions/Dialogs/exitDialog.dart';
import 'package:unversityapp/view/Widgets/MainPages/Settings/advancedFeatures/CreateExamWidgets/choice_questions.dart';
import 'package:unversityapp/view/Widgets/MainPages/Settings/advancedFeatures/CreateExamWidgets/question_add_line.dart';
import 'package:unversityapp/view/Widgets/MainPages/Settings/advancedFeatures/CreateExamWidgets/true_false_questions.dart';
import 'package:unversityapp/view/Widgets/shared/CustomAppBar.dart';
import 'package:unversityapp/view/Widgets/shared/CustomButton.dart';
import 'package:unversityapp/view/Widgets/shared/CustomTextField.dart';
import 'package:unversityapp/view/Widgets/shared/custom_check_box.dart';

class CreateExamPage extends GetView<CreateExamController> {
  const CreateExamPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar("صَمِّم أختبارك", context, enableActions: false),
      body: GetBuilder<CreateExamController>(
        builder: (controller) => PopScope(
          canPop: true,
          onPopInvoked: (didPop) => stopBackDialog(),
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
            children: [
              CustomTextField(
                hint: "أدخل اسم الفرع هنا...",
                label: "الفرع:",
                readOnly: !controller.canEditStudy,
                editingController: controller.studyNameController,
                borderRadius: 10,
                maxchar: 36,
              ),
              const SizedBox(
                height: 10,
              ),
              CustomCheckBox(
                  text: "أستخدام اسم فرعك الحالي",
                  checked: !controller.canEditStudy,
                  onChanged: () => controller.changeStudyState()),
              const SizedBox(
                height: 10,
              ),
              CustomTextField(
                hint: "أدخل اسم المادّة هنا...",
                label: "المادّة:",
                editingController: controller.subjectNameController,
                maxchar: StaticData.subjectMaxChar,
                borderRadius: 10,
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                alignment: Alignment.centerRight,
                margin: const EdgeInsets.only(right: 5),
                child: CustomButton(
                  text: "أختيار مادة",
                  onPressed: () => controller.chooseSubject(context),
                  height: 45,
                  minWidth: 60,
                  borderRadius: 10,
                  fontSize: 15,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const QuestionAddLine(isTrueFalse: true),
              const SizedBox(
                height: 10,
              ),
              const TrueFalseQuestions(),
              const SizedBox(
                height: 20,
              ),
              const QuestionAddLine(isTrueFalse: false),
              const SizedBox(
                height: 10,
              ),
              const ChoiceQuestions(),
              const SizedBox(
                height: 10,
              ),
              CustomButton(
                  text: "حفظ الأختبار", onPressed: () => controller.saveExam())
            ],
          ),
        ),
      ),
    );
  }
}
