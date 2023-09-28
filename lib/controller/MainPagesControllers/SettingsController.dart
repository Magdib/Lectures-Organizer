import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:permission_handler/permission_handler.dart';
import 'package:unversityapp/core/Routes/routes.dart';
import 'package:unversityapp/core/functions/Dialogs/CreatePdfDialog.dart';
import 'package:unversityapp/core/functions/Dialogs/SettingsDialogs.dart';
import 'package:unversityapp/core/functions/GlobalFunctions/hiveNullCheck.dart';
import '../../core/Constant/HiveData/HiveKeysBoxes.dart';

abstract class SettingsController extends GetxController {
  void changeTheme(bool value, BuildContext context);
  void changeViewer(int index);
  void refreshYearData();
  void getAverage(int state);
  void createPdf();
  Future<void> goToMusicPage(int x);
}

class SettingsControllerimp extends SettingsController {
  Box userDataBox = Hive.box(HiveBoxes.userDataBox);
  late String studentName;
  late String studentStudy;
  late String yearAsString;
  late List<String> userDataList;
  late int currentYear;
  late int numberOfYears;
  bool? darkmood;
  double? time;
  late List<Map<String, dynamic>> settingsFeatures;
  late int selectedViewer;
  //Average and Degree
  int? degreeLength;
  double? average;

  @override
  void changeTheme(bool value, BuildContext context) {
    darkmood = value;
    userDataBox.put(HiveKeys.isDarkMood, darkmood);

    if (darkmood == false) {
      Get.changeThemeMode(ThemeMode.light);
    } else {
      Get.changeThemeMode(ThemeMode.dark);
    }

    update();
  }

  @override
  void changeViewer(int index) async {
    selectedViewer = index;
    update();
    await userDataBox.put(HiveKeys.selectedViewer, index);
    Get.back();
  }

  @override
  void refreshYearData() {
    userDataBox.put(HiveKeys.currentYearToWord, yearAsString);
    userDataList[2] = 'السنة الحالية : $yearAsString';
    userDataList[1] = 'الفرع : $studentStudy';
    userDataList[0] = 'اسم الطالب : $studentName';
    update();
  }

  @override
  void getAverage(int state) {
    average = hiveNullCheck(HiveKeys.average, 0.0);
    // userDataBox.get(HiveKeys.average) == null
    //     ? average = 0.0
    //     : average = userDataBox.get(HiveKeys.average);
    if (state == 1) {
      userDataList[3] = 'المعدل : ${average!.toStringAsFixed(1)}';
    }
    update();
  }

  @override
  void createPdf() async {
    final pdf = pw.Document();
    FilePickerResult? result = await FilePicker.platform.pickFiles(
        allowedExtensions: ['png', "jpg", "jpeg"],
        initialDirectory: "/storage/emulated/0/DCIM",
        type: FileType.custom,
        allowMultiple: true);
    if (result != null) {
      for (int i = 0; i < result.files.length; i++) {
        PlatformFile pickedImage = result.files[i];
        final image = pw.MemoryImage(
          File(pickedImage.path!).readAsBytesSync(),
        );
        pdf.addPage(pw.Page(build: (pw.Context context) {
          return pw.Center(
              child: pw.Image(
            image,
          )); // Center
        }));
      }
      createPdfDialog(pdf);
    }
  }

  @override
  Future<void> goToMusicPage(int x) async {
    PermissionStatus p = await Permission.storage.status;
    if (p.isDenied) {
      await Permission.storage.request();
      if (x == 0) {
        goToMusicPage(1);
      }
    } else {
      Get.toNamed(AppRoutes.musicPageRoute);
    }
  }

  @override
  void onInit() {
    studentName = userDataBox.get(HiveKeys.name);
    studentStudy = userDataBox.get(HiveKeys.study);
    yearAsString = userDataBox.get(HiveKeys.currentYearToWord);
    currentYear = userDataBox.get(HiveKeys.currentYear);
    numberOfYears = userDataBox.get(HiveKeys.numberofYears);
    selectedViewer = hiveNullCheck(HiveKeys.selectedViewer, 0);
    if (userDataBox.get(HiveKeys.isDarkMood) == false ||
        userDataBox.get(HiveKeys.isDarkMood) == null) {
      darkmood = false;
    } else {
      darkmood = true;
    }
    if (userDataBox.get(HiveKeys.studyTime) == 0 ||
        userDataBox.get(HiveKeys.studyTime) == null) {
      time = 0;
    } else {
      time = userDataBox.get(HiveKeys.studyTime);
    }
    getAverage(0);
    userDataList = [
      'اسم الطالب : $studentName',
      'الفرع : $studentStudy',
      'السنة الحالية : $yearAsString',
      'المعدل : ${average!.toStringAsFixed(1)}',
      'وقت الدراسة الكلي : ${time!.toStringAsFixed(2)} ساعة'
    ];
    settingsFeatures = [
      {
        "text": 'إضافة درجات المواد',
        "icon": Icons.menu_book,
        "function": () => Get.toNamed(AppRoutes.degreesPageRoute)
      },
      {
        "text": "نوع المشغّل",
        "icon": Icons.my_library_books_outlined,
        "function": () => selectViewerDialog()
      },
      {
        "text": 'الوضع السريع',
        "icon": Icons.flash_on_outlined,
        "function": () => Get.toNamed(AppRoutes.fastChooseSubjectRoute)
      },
      {
        "text": 'تحويل صور إلى pdf',
        "icon": Icons.picture_as_pdf_outlined,
        "function": () => createPdf()
      },
      {
        "text": 'موسيقى',
        "icon": Icons.my_library_music_outlined,
        "function": () => goToMusicPage(0)
      },
      {
        "text": 'البيانات الشخصية',
        "icon": Icons.manage_accounts_outlined,
        "function": () => Get.toNamed(AppRoutes.profilePageRoute)
      },
      {
        "text": 'حول التطبيق',
        "icon": Icons.info_outline,
        "function": () => Get.toNamed(AppRoutes.aboutAppRoute)
      },
    ];
    super.onInit();
  }
}
