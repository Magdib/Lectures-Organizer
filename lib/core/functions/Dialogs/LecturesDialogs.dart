import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:unversityapp/controller/NormalUsePagesControllers/LecturePageController.dart';
import 'package:unversityapp/core/Constant/AppColors.dart';
import 'dart:io';
import '../../../view/Widgets/NormalUsePages/LecturesPage/ChooseLectureButton.dart';
import '../../../view/Widgets/NormalUsePages/LecturesPage/LectureConfirmButton.dart';
import '../../../view/Widgets/NormalUsePages/LecturesPage/LectureTypeColumn.dart';
import '../../../view/Widgets/shared/DialogButton.dart';
import '../RichText/RichTextStyles.dart';

lectureaddDialog(
  BuildContext context,
) {
  final LecturePageControllerimp lecturePageController = Get.find();
  Get.defaultDialog(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      title: 'إضافة محاضرة',
      barrierDismissible: false,
      titleStyle: TextStyle(
          fontSize: 25,
          color: Theme.of(context).primaryColor,
          fontWeight: FontWeight.bold),
      actions: [const LectureTypeColumn()],
      content: const ChooseLectureButton(),
      confirm: const LectureConfirmButton(),
      cancel: DialogButton(
          onPressed: () => lecturePageController.onWillPop(),
          text: "إلغاء الأمر"));
}

deleteLectureDialog(BuildContext context) {
  LecturePageControllerimp controller = Get.find();
  return Get.defaultDialog(
      titleStyle: Theme.of(context).textTheme.headline1,
      title: 'حذف المادة',
      content: RichText(
          text: TextSpan(children: <TextSpan>[
        richTextBlack(
            context, 'سيتم حذف المادة مع جميع محاضراتها للتأكيد أضغط على '),
        richTextBlue(context, 'تأكيد')
      ])),
      cancel: DialogButton(
        text: "إلغاء الأمر",
        onPressed: () => Get.back(),
      ),
      confirm: DialogButton(
        text: 'تأكيد',
        onPressed: () => controller.deleteSubject(context),
      ));
}

lectureDataDialog(BuildContext context, int index) {
  LecturePageControllerimp controller = Get.find();

  int? numberOfPages = controller.currentLectures[index].numberofPages;
  return numberOfPages != 0
      ? Get.defaultDialog(
          titleStyle: Theme.of(context).textTheme.headline1,
          title: 'معلومات المحاضرة',
          onWillPop: () => controller.onWillPopDetailes(),
          content: RichText(
              text: TextSpan(children: <TextSpan>[
            richTextDBlack(context, "الاسم: "),
            richTextBlack(context,
                " ${controller.currentLectures[index].lecturename.replaceAll('.pdf', '')}\n\n"),
            richTextDBlack(context, "النوع: "),
            richTextBlack(context,
                "${controller.currentLectures[index].lecturetype}\n\n"),
            richTextDBlack(context, "عدد الصفحات: "),
            richTextBlack(context, "$numberOfPages \n\n"),
            richTextDBlack(context, "حجم الملف: "),
            richTextBlack(context,
                "${(File(controller.currentLectures[index].lecturepath).lengthSync() / (1024 * 1024)).toStringAsFixed(2)} ميغا بايت\n\n"),
            richTextDBlack(context, "الحالة: "),
            richTextBlack(context,
                '${controller.currentLectures[index].check == true ? "تمت دراستها" : "لم تدرس بعد"}\n\n'),
            controller.currentLectures[index].offset == 0.1
                ? richTextDBlack(context, 'تاريخ الإضافة: ')
                : richTextDBlack(context, 'تاريخ آخر دراسة: '),
            richTextBlack(context,
                "${controller.currentLectures[index].time.replaceRange(10, null, '')}\n\n"),
            controller.currentLectures[index].offset == 0.1
                ? richTextDBlack(context, "وقت الإضافة: ")
                : richTextDBlack(context, "وقت آخر دراسة: "),
            richTextBlack(
                context,
                controller.currentLectures[index].time
                    .replaceRange(0, 10, '')
                    .replaceRange(6, null, ''))
          ])),
          cancel: DialogButton(
            text: "حذف",
            onPressed: () => controller.deleteLecture(index),
          ),
          confirm: DialogButton(
            text: 'فتح',
            onPressed: () {
              Get.back();
              controller.openLecture(index);
            },
          ))
      : Get.defaultDialog(
          backgroundColor: AppColors.white.withOpacity(0),
          title: '',
          content: Center(
            child: CircularProgressIndicator(
                backgroundColor: AppColors.deepred,
                color: Theme.of(context).primaryColor),
          ),
          actions: [
              SizedBox(
                height: 0,
                width: 0,
                child: SfPdfViewer.file(
                  File(controller.currentLectures[index].lecturepath),
                  pageLayoutMode: PdfPageLayoutMode.single,
                  onDocumentLoadFailed: (s) async {
                    await Future.delayed(const Duration(seconds: 2));
                    Get.back();
                    controller.currentLectures[index].numberofPages = 1;
                  },
                  onDocumentLoaded: (details) =>
                      controller.getNumberOfPages(details, context, index),
                ),
              )
            ]);
}
