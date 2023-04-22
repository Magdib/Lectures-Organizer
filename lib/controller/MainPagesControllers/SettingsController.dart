import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:unversityapp/controller/MainPagesControllers/HomePageController.dart';
import 'package:unversityapp/core/functions/Dialogs/NextYearDialog.dart';
import 'package:unversityapp/core/functions/validation/CurrentYearFuntions.dart';

import '../../core/Constant/HiveData/HiveKeysBoxes.dart';
import '../../view/Widgets/shared/BlueSnackBar.dart';

abstract class SettingsController extends GetxController {
  void changeTheme(bool value, BuildContext context);
  void nextYearMethod(BuildContext context);
  void confirmChangeYear();
  void getAverage(int state);
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
  void nextYearMethod(BuildContext context) {
    if (currentYear < numberOfYears) {
      nextYearDialog(context, currentYear);
    } else {
      blueSnackBar('أحسنت', "مبارك تخرجك", context);
    }
    update();
  }

  @override
  void confirmChangeYear() {
    HomePageControllerimp homePageController = Get.find();
    currentYear = currentYear + 1;
    yearAsString = yearToStringfunction(currentYear, numberOfYears);
    String yearWord = yearWordFunction(currentYear, numberOfYears);
    Get.back();
    userDataBox.put(HiveKeys.currentYearToWord, yearAsString);
    userDataList[2] = 'السنة الحالية : $yearAsString';
    userDataBox.put(HiveKeys.currentYear, currentYear);
    userDataBox.put(HiveKeys.yearWord, yearWord);
    homePageController.yearWord = yearWord;
    update();
  }

  @override
  void getAverage(int state) {
    userDataBox.get(HiveKeys.average) == null
        ? average = 0.0
        : average = userDataBox.get(HiveKeys.average);
    if (state == 1) {
      userDataList[3] = 'المعدل : ${average!.toStringAsFixed(1)}';
    }
    update();
  }

  @override
  void onInit() {
    studentName = userDataBox.get(HiveKeys.name);
    studentStudy = userDataBox.get(HiveKeys.study);
    yearAsString = userDataBox.get(HiveKeys.currentYearToWord);
    currentYear = userDataBox.get(HiveKeys.currentYear);
    numberOfYears = userDataBox.get(HiveKeys.numberofYears);
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

    super.onInit();
  }
}
