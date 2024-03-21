import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unversityapp/controller/settingsPagesController/advancedfeaturescontrollers/create_exam_controller.dart';

class QuestionAddLine extends StatelessWidget {
  const QuestionAddLine({
    super.key,
    required this.isTrueFalse,
  });
  final bool isTrueFalse;
  @override
  Widget build(BuildContext context) {
    return GetBuilder<CreateExamController>(
      builder: (controller) =>
          (isTrueFalse && controller.trueFalseQuestions.length < 20) ||
                  (!isTrueFalse && controller.choiceQuestions.length < 20)
              ? Row(
                  children: [
                    const SizedBox(
                      width: 5,
                    ),
                    SizedBox(
                      width: 15,
                      child: Divider(
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    InkWell(
                      onTap: () => controller.addQuestion(isTrueFalse, context),
                      child: Row(
                        children: [
                          Icon(
                            Icons.add,
                            color: Theme.of(context).primaryColor,
                            size: 20,
                          ),
                          Text(
                            isTrueFalse ? "صح أو خطأ" : "أختر الإجابة الصحيحة",
                            style: Theme.of(context)
                                .textTheme
                                .headline1!
                                .copyWith(fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Divider(
                        indent: 5,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ],
                )
              : const SizedBox(),
    );
  }
}
