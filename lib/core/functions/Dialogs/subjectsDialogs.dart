import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unversityapp/view/Widgets/NormalUsePages/subjectsPage/SubjectEditeButton.dart';

import '../../../controller/NormalUsePagesControllers/SubjectsPageController.dart';

import '../../../view/Widgets/shared/DialogButton.dart';
import '../../../view/Widgets/NormalUsePages/subjectsPage/SubjectConfirmButton.dart';
import '../../../view/Widgets/NormalUsePages/subjectsPage/TermButtonsCloumn.dart';
import '../../../view/Widgets/shared/TextFormField.dart';
import '../RichText/RichTextStyles.dart';

void addSubjectDialog(BuildContext context) {
  SubjectsPageControllerimp controller = Get.find();
  Get.defaultDialog(
      titlePadding: const EdgeInsets.only(top: 8, bottom: 0),
      contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 13),
      barrierDismissible: false,
      title: 'إضافة مادة',
      titleStyle: Theme.of(context).textTheme.headline1,
      actions: [
        const RadioButtonsCloumn(),
      ],
      content: SizedBox(
        height: 60,
        child: CustomTextField(
            hint: 'أدخل اسم المادة هنا ...',
            onchange: (val) {
              controller.handelSubjectButtonState();
            },
            editingController: controller.subjectNameController!,
            maxchar: 30),
      ),
      confirm: const SubjectConfirmButton(),
      cancel: DialogButton(
          onPressed: () => controller.onWillPop(), text: "إلغاء الأمر"));
}

void editSubjectDialog(BuildContext context, int index) {
  Get.back();
  SubjectsPageControllerimp controller = Get.find();
  //initial Value
  controller.editSubjectController!.text =
      controller.currentYearSubjects[index].subjectName!;
  controller.editTermFunction(controller.currentYearSubjects[index].term);
  //current Subject Index
  final int elementindex = controller.subjects.indexWhere((element) =>
      element.subjectName!.startsWith(controller.editSubjectController!.text));

  controller.subjectButtonState = true;
  Get.defaultDialog(
      titlePadding: const EdgeInsets.only(top: 8, bottom: 0),
      contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 13),
      barrierDismissible: false,
      title: 'تعديل مادة',
      titleStyle: Theme.of(context).textTheme.headline1,
      actions: [
        const RadioButtonsCloumn(),
      ],
      content: SizedBox(
        height: 60,
        child: CustomTextField(
            onchange: (val) {
              controller.handelSubjectButtonState();
            },
            editingController: controller.editSubjectController!,
            maxchar: 22),
      ),
      confirm: SubjectEditButton(
        index: index,
        elementindex: elementindex,
      ),
      cancel: DialogButton(
          onPressed: () => controller.onWillPop(), text: "إلغاء الأمر"));
}

subjectStateDialog(BuildContext context, int index) {
  SubjectsPageControllerimp subjectscontroller = Get.find();
  return Get.defaultDialog(
      title: 'تعديل بيانات المادة',
      content: RichText(
          text: TextSpan(children: <TextSpan>[
        richTextBlack(context, "أضغط على "),
        richTextBlue(context, "تعديل "),
        richTextBlack(context, 'لتعديل بيانات المادة أو أضغط مطولاً على '),
        richTextBlue(context, "حذف "),
        richTextBlack(context, "لحذف المادة مع جميع محاضراتها")
      ])),
      titleStyle: Theme.of(context).textTheme.headline1,
      confirm: DialogButton(
          onPressed: () => editSubjectDialog(context, index), text: 'تعديل'),
      cancel: DialogButton(
          onLongPress: () => subjectscontroller.deleteSubject(index),
          text: 'حذف'));
}
