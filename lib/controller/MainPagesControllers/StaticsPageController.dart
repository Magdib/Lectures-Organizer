import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:unversityapp/core/Constant/HiveData/HiveKeysBoxes.dart';
import 'package:unversityapp/model/StaticsPageModel.dart';

import '../../core/Constant/AppColors.dart';
import '../../core/functions/GlobalFunctions/hiveNullCheck.dart';

abstract class StaticsController extends GetxController {
  void studyStateCheck();
  Color getCircleColor(double circlepercent);
  void getData(int state);
}

class StaticsControllerimp extends StaticsController {
  Box userDataBox = Hive.box(HiveBoxes.userDataBox);
  late double average;
  late String studyState;
  late Color studyStateColor;
  late String yearAsString;
  late int currentYear;
  late int numberofYears;
  late int maxDegree;
  late int minDegree;
  late List<StaticsPageModel> progressList;
  @override
  void studyStateCheck() {
    if (average > 100) {
      studyState = "إمّا نابغة أو منافق";
      studyStateColor = AppColors.deepGreen;
    } else if (average > 90) {
      studyState = " ممتاز";
      studyStateColor = AppColors.white;
    } else if (average > 80) {
      studyState = " جيد جداً";
      studyStateColor = AppColors.green;
    } else if (average > 70) {
      studyState = " جيد";
      studyStateColor = AppColors.yellow;
    } else if (average > 60) {
      studyState = " غير جيد ";
      studyStateColor = AppColors.deepred;
    } else if (average > 0 && average < 60) {
      studyState = " سيء";
      studyStateColor = AppColors.veryDeepRed;
    } else {
      studyState = " فارغ";
      studyStateColor = AppColors.grey;
    }
  }

  @override
  Color getCircleColor(double circlepercent) {
    Color circleColor;
    if (circlepercent < 0.6) {
      circleColor = AppColors.moreDeepred;
    } else if (circlepercent < 0.8) {
      circleColor = AppColors.yellow;
    } else if (circlepercent < 1) {
      circleColor = AppColors.green;
    } else {
      circleColor = AppColors.white;
    }
    return circleColor;
  }

  @override
  void getData(int state) {
    average = hiveNullCheck(HiveKeys.average, 0.0);
    maxDegree = hiveNullCheck(HiveKeys.maxDegree, 0);
    minDegree = hiveNullCheck(HiveKeys.minDegree, 0);
    yearAsString = userDataBox.get(HiveKeys.currentYearToWord);
    currentYear = userDataBox.get(HiveKeys.currentYear);
    numberofYears = userDataBox.get(HiveKeys.numberofYears);
    studyStateCheck();

    progressList = [
      StaticsPageModel(
          title: 'المعدل',
          centerText: average.toStringAsFixed(1),
          circlePercent: average / 100,
          fontSizeFix: 25,
          circleColor: getCircleColor(average / 100)),
      StaticsPageModel(
          title: 'السنة',
          centerText: yearAsString,
          circlePercent: currentYear / numberofYears,
          fontSizeFix: 15,
          circleColor: getCircleColor(currentYear / numberofYears)),
      StaticsPageModel(
          title: 'أعلى درجة',
          centerText: "$maxDegree",
          circlePercent: maxDegree / 100,
          fontSizeFix: 25,
          circleColor: getCircleColor(maxDegree / 100)),
      StaticsPageModel(
          title: 'أدنى درجة',
          centerText: "$minDegree",
          circlePercent: minDegree / 100,
          fontSizeFix: 25,
          circleColor: getCircleColor(minDegree / 100))
    ];
    if (state == 1) {
      update();
    }
  }

  @override
  void onInit() {
    getData(0);
    super.onInit();
  }
}
