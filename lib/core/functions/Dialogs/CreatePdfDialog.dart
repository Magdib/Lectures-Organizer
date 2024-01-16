import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:open_file/open_file.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:permission_handler/permission_handler.dart';
import 'package:unversityapp/core/functions/snackBars/ErrorSnackBar.dart';
import 'package:unversityapp/view/Widgets/shared/BlueSnackBar.dart';
import 'package:unversityapp/view/Widgets/shared/DialogButton.dart';
import 'package:unversityapp/view/Widgets/shared/TextFormField.dart';

createPdfDialog(pw.Document pdf) {
  final TextEditingController pdfNameController = TextEditingController();
  return Get.defaultDialog(
      titlePadding: const EdgeInsets.only(top: 8, bottom: 0),
      contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 13),
      title: 'اسم المحاضرة',
      titleStyle: Get.textTheme.headline1,
      content: CustomTextField(
        hint: "أدخل اسم المحاضرة هنا...",
        editingController: pdfNameController,
      ),
      cancel: DialogButton(
        text: "إلغاء",
        onPressed: () {
          Get.back();
          pdfNameController.dispose();
        },
      ),
      confirm: DialogButton(
        text: "تأكيد",
        onPressed: () async {
          PermissionStatus p = await Permission.storage.status;
          PermissionStatus mes = await Permission.manageExternalStorage.status;
          Get.back();
          if (p.isDenied) {
            await Permission.storage.request();
          }
          if (mes.isDenied) {
            await Permission.manageExternalStorage.request();
          }
          if (pdfNameController.text.isEmpty) {
            pdfNameController.text = "Test";
          }
          String saveFolder = "/storage/emulated/0/Download/منسق المحاضرات/";
          try {
            final file = File('$saveFolder${pdfNameController.text}.pdf');
            Directory? lectureDir = Directory(saveFolder);
            if (lectureDir.existsSync() == false) {
              Directory(saveFolder).createSync();
            }
            await file.writeAsBytes(await pdf.save());
            blueSnackBar("تمت العملية بنجاح",
                "تم إنشاء الملف ${pdfNameController.text}.pdf وحفظه في ذاكرة الجهاز سيتم فتح الملف بعد قليل...",
                duration: const Duration(seconds: 5));
            await Future.delayed(const Duration(seconds: 6));
            OpenResult openResult =
                await OpenFile.open('$saveFolder${pdfNameController.text}.pdf');
            log(openResult.message);
          } catch (e) {
            errorSnackBar("خطأ", "الخدمة غير مدعومة في نظامك");
          }

          pdfNameController.dispose();
        },
      ));
}
