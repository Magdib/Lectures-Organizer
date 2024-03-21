import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:unversityapp/core/Constant/AppColors.dart';
import 'package:unversityapp/core/Constant/HiveData/HiveKeysBoxes.dart';
import 'package:unversityapp/core/Constant/static_data.dart';
import 'package:unversityapp/core/Routes/routes.dart';
import 'package:unversityapp/core/class/app_toasts.dart';
import 'package:unversityapp/model/HiveAdaptersModels/FeaturesModel/exam_models.dart';
import 'package:unversityapp/model/HiveAdaptersModels/NormalUseModels/SubjectsAdapter.dart';
import 'package:unversityapp/view/Widgets/NormalUsePages/subjectsPage/RadioButton.dart';
import 'package:unversityapp/view/Widgets/shared/DialogButton.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class CreateExamController extends GetxController {
  late TextEditingController subjectNameController;
  late TextEditingController studyNameController;
  late stt.SpeechToText speech;
  bool canEditStudy = true;
  late Box<SubjectsPageModel> subjectsBox;
  late List<SubjectsPageModel> subjects;
  List<TrueFalseQuestionsModel> trueFalseQuestions = [];
  List<ChoiceQuestionsModel> choiceQuestions = [];
  bool canPop = false;
  double numberOfQuestions = 1;
  changeStudyState() {
    if (canEditStudy) {
      studyNameController.text =
          Hive.box(HiveBoxes.userDataBox).get(HiveKeys.study);
    } else {
      studyNameController.clear();
    }
    canEditStudy = !canEditStudy;
    update();
  }

  chooseSubject(BuildContext context) {
    Get.defaultDialog(
        title: "أختر مادة",
        titleStyle: Theme.of(context).textTheme.headline1,
        content: SizedBox(
          height: StaticData.deviceHeight / 2.2,
          width: StaticData.deviceWidth,
          child: ListView.builder(
              itemCount: subjects.length,
              itemBuilder: (context, index) {
                String subName = subjects[index].subjectName!;
                if (subName.length > 12) {
                  subName = subName.replaceRange(12, null, "");
                  subName = "$subName...";
                }
                return RadioButton(
                    text: subName,
                    onChanged: subjectNameController.text ==
                            subjects[index].subjectName!
                        ? null
                        : () {
                            subjectNameController.text =
                                subjects[index].subjectName!;
                            Get.back();
                            update();
                          });
              }),
        ));
  }

  changeQuestionNum(double val) {
    numberOfQuestions = val;
    update();
  }

  addQuestion(bool isTrueFalse, BuildContext context) {
    Get.defaultDialog(
        titlePadding: const EdgeInsets.only(top: 8, bottom: 0),
        contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 13),
        title: "عدد الأسئلة",
        titleStyle: Get.textTheme.headline1,
        content: GetBuilder<CreateExamController>(
          builder: (controller) => Column(
            children: [
              Slider(
                inactiveColor: AppColors.grey,
                value: controller.numberOfQuestions,
                min: 1,
                max: isTrueFalse
                    ? (trueFalseQuestions.length < 20
                            ? 20 - trueFalseQuestions.length
                            : 1)
                        .toDouble()
                    : (choiceQuestions.length < 20
                            ? 20 - choiceQuestions.length
                            : 1)
                        .toDouble(),
                label: "${controller.numberOfQuestions}",
                onChanged: (val) => controller.changeQuestionNum(val),
              ),
              Text(
                "${controller.numberOfQuestions.round()} سؤال",
                style: Theme.of(context)
                    .textTheme
                    .headline1!
                    .copyWith(fontSize: 15),
              )
            ],
          ),
        ),
        onWillPop: () {
          numberOfQuestions = 1;
          Get.back();
          return Future.value(false);
        },
        cancel: DialogButton(
          text: "إلغاء",
          onPressed: () {
            numberOfQuestions = 1;
            Get.back();
          },
        ),
        confirm: DialogButton(
          text: "تأكيد",
          onPressed: () {
            Get.back();
            numberOfQuestions = numberOfQuestions.round().toDouble();
            for (int i = 0; i < numberOfQuestions; i++) {
              if (isTrueFalse) {
                trueFalseQuestions.add(TrueFalseQuestionsModel());
              } else {
                choiceQuestions.add(ChoiceQuestionsModel(choices: ["", ""]));
              }
            }
            numberOfQuestions = 1;
            update();
          },
        ));
  }

  addChoiceQuestion(int index) {
    choiceQuestions[index].choices.add("");
    update();
  }

  setTrueFalseAnswer(bool isTrue, int index) {
    trueFalseQuestions[index].answer = isTrue;
    update();
  }

  deleteQuestion(int index, bool isTrueFalse) async {
    isTrueFalse
        ? trueFalseQuestions.removeAt(index)
        : choiceQuestions.removeAt(index);
    update();
  }

  deleteChoice(int index, int gridIndex) {
    choiceQuestions[index].choices.removeAt(gridIndex);
    update();
  }

  onChangeQuestionText(int index, bool isTrueFalse, String val) {
    if (isTrueFalse) {
      trueFalseQuestions[index].question = val;
    } else {
      choiceQuestions[index].question = val;
    }
  }

  onChangedAnswerText(int index, int gridIndex, String val) {
    choiceQuestions[index].choices[gridIndex] = val;
  }

  chooseRightQuestion(int index, int gridIndex) {
    if (choiceQuestions[index].choices[gridIndex].isNotEmpty) {
      if (choiceQuestions[index].correctIndex == gridIndex) {
        choiceQuestions[index].correctIndex = null;
      } else {
        choiceQuestions[index].correctIndex = gridIndex;
      }
      update();
    } else {
      AppToasts.showErrorToast("الجواب فارغ");
    }
  }

  bool checkTrueFalseQuestions() {
    bool canSave = true;
    for (int i = 0; i < trueFalseQuestions.length; i++) {
      if (trueFalseQuestions[i].question.isEmpty ||
          trueFalseQuestions[i].answer == null) {
        canSave = false;
      }
    }
    return canSave;
  }

  bool checkChoiceQuestions() {
    bool canSave = true;
    for (int i = 0; i < choiceQuestions.length; i++) {
      if (choiceQuestions[i].question.isEmpty ||
          choiceQuestions[i].correctIndex == null) {
        canSave = false;
      } else {
        for (int index = 0;
            index < choiceQuestions[i].choices.length;
            index++) {
          if (choiceQuestions[i].choices[index].isEmpty) {
            canSave = false;
          }
        }
      }
    }
    return canSave;
  }

  listenToQuestion(int index, bool isTrueFalse, BuildContext context) async {
    bool canPop = true;
    bool available = await speech.initialize(
        onStatus: (status) => print("status === $status"),
        onError: (errorNotification) {
          if (canPop) {
            AppToasts.showErrorToast("حدث خطأ ما تحقق من إتصالك بالإنترنت");
            canPop = false;
            Get.back();
          }
        });
    if (available) {
      speech.listen(
        localeId: "ar",
        onResult: (result) {
          onChangeQuestionText(index, isTrueFalse, result.recognizedWords);
          update();
        },
      );
    } else {
      AppToasts.showErrorToast("الرجاء السماح باستخدام المايكروفون");
    }
    double value = 10;
    Get.dialog(
        PopScope(
          onPopInvoked: (didPop) => canPop = false,
          child: GetBuilder<CreateExamController>(
            builder: (controller) => CircularPercentIndicator(
              radius: 80,
              animation: true,
              percent: value * 0.1,
              lineWidth: 20,
              animateFromLastPercent: true,
              center: Text(
                "$value".replaceAll(".0", ""),
                style: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(fontSize: 25),
              ),
              backgroundColor: Colors.transparent,
              progressColor: AppColors.white,
            ),
          ),
        ),
        barrierDismissible: false);
    Timer.periodic(const Duration(seconds: 1), (timer) {
      value--;
      update();
      if (value == 0 && canPop) {
        speech.stop();
        timer.cancel();
        Get.back();
      } else if (!canPop) {
        timer.cancel();
      }
    });
  }

  saveExam() {
    if (trueFalseQuestions.isNotEmpty && choiceQuestions.isNotEmpty) {
      if (studyNameController.text.isNotEmpty &&
          subjectNameController.text.isNotEmpty &&
          checkTrueFalseQuestions() &&
          checkChoiceQuestions()) {
      } else {
        AppToasts.showErrorToast("تأكد من تعبئة جميع الحقول");
      }
    } else {
      AppToasts.showErrorToast("لا يمكن أن يكون الأختبار بدون أسئلة");
    }
  }

  allowPop() {
    Get.back();
    canPop = true;
    update();
  }

  @override
  void onInit() {
    subjectNameController = TextEditingController();
    studyNameController = TextEditingController();
    speech = stt.SpeechToText();
    super.onInit();
  }

  @override
  void onReady() async {
    subjectsBox = await Hive.openBox(HiveBoxes.subjectsBox);
    subjects = subjectsBox.values.toList();
    super.onReady();
  }

  @override
  void onClose() {
    subjectNameController.dispose();
    studyNameController.dispose();
    subjectsBox.close();
    speech.cancel();
    super.onClose();
  }
}
