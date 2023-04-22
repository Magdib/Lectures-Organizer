import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:unversityapp/core/class/enums/DataState.dart';

import '../../core/Constant/HiveData/HiveKeysBoxes.dart';
import '../../core/functions/GlobalFunctions/hiveNullCheck.dart';
import '../../core/functions/snackBars/ErrorSnackBar.dart';
import '../../model/HiveAdaptersModels/DegreesAdapter.dart';

abstract class DegreesController extends GetxController {
  void addDegree();
  void chooseDegree(double val);
  void handleButtonState(String val);
  onWillPop();
  void deleteDegree(int index);
}

class DegreesControllerimp extends DegreesController {
  late Box<DegreesModel> degreesBox;
  Box userDataBox = Hive.box(HiveBoxes.userDataBox);
  TextEditingController? degreeTextController;
  List<DegreesModel> degrees = [];
  late int minDegree;
  double degree = 60;
  late int maxDegree;
  late int degreesSum;
  late double average;
  bool buttonState = false;
  DataState dataState = DataState.loading;
  @override
  void chooseDegree(double val) {
    degree = val;
    update();
  }

  @override
  addDegree() {
    if (minDegree == 0) minDegree = 100;
    if (degrees.any((subject) =>
            subject.subjectName.contains(degreeTextController!.text)) ==
        true) {
      errorSnackBar('المادة موجودة سابقاً',
          "الرجاء إضافة مادة أخرى أو كتابة اسم المادة كاملاً في حالة تطابق الأسماء في البداية");
    } else {
      int degreeRounded = degree.round();
      degreesSum = degreesSum + degreeRounded;
      userDataBox.put(HiveKeys.degreesSum, degreesSum);
      degrees.add(DegreesModel(
          degree: degreeRounded, subjectName: degreeTextController!.text));
      average = degreesSum / degrees.length;
      degreesBox.add(degrees[degrees.length - 1]);
      userDataBox.put(HiveKeys.average, average);
      if (degreeRounded > maxDegree) {
        maxDegree = degreeRounded;
        userDataBox.put(HiveKeys.maxDegree, maxDegree);
      }
      if (degreeRounded < minDegree) {
        minDegree = degreeRounded;
        userDataBox.put(HiveKeys.minDegree, minDegree);
      }
      if (dataState == DataState.empty) {
        dataState = DataState.notEmpty;
      }
      Get.back();
      degreeTextController!.clear();
    }

    update();
  }

  @override
  void handleButtonState(String val) {
    if (val.length > 2) {
      buttonState = true;
    } else {
      buttonState = false;
    }
    update();
  }

  @override
  deleteDegree(int index) {
    if (degrees.length > 1) {
      if (degrees[index].degree == minDegree) {
        minDegree = 100;
        for (int i = 0; i < degrees.length; i++) {
          if (i == index) continue;
          if (degrees[i].degree < minDegree) {
            minDegree = degrees[i].degree;
            userDataBox.put(HiveKeys.minDegree, minDegree);
          }
        }
      } else if (degrees[index].degree == maxDegree) {
        maxDegree = 0;
        for (int i = 0; i < degrees.length; i++) {
          if (i == index) continue;
          if (degrees[i].degree > maxDegree) {
            maxDegree = degrees[i].degree;
            userDataBox.put(HiveKeys.maxDegree, maxDegree);
          }
        }
      }
      degreesSum = degreesSum - degrees[index].degree;
      degreesBox.deleteAt(index);
      degrees.removeAt(index);
      average = degreesSum / degrees.length;
      userDataBox.put(HiveKeys.average, average);
      userDataBox.put(HiveKeys.degreesSum, degreesSum);
    } else {
      degreesSum = degreesSum - degrees[index].degree;
      degreesBox.deleteAt(index);
      degrees.removeAt(index);
      userDataBox.put(HiveKeys.average, 0.0);
      userDataBox.put(HiveKeys.degreesSum, 0);
      userDataBox.put(HiveKeys.maxDegree, 0);
      userDataBox.put(HiveKeys.minDegree, 0);

      dataState = DataState.empty;
    }
    update();
  }

  @override
  onWillPop() {
    degreeTextController!.clear();
    buttonState = false;
    Get.back();
  }

  @override
  void onInit() {
    degreeTextController = TextEditingController();
    average = hiveNullCheck(HiveKeys.average, 0.0);
    minDegree = hiveNullCheck(HiveKeys.minDegree, 100);
    maxDegree = hiveNullCheck(HiveKeys.maxDegree, 0);
    degreesSum = hiveNullCheck(HiveKeys.degreesSum, 0);
    super.onInit();
  }

  @override
  void onReady() async {
    degreesBox = await Hive.openBox(HiveBoxes.degreesBox);

    if (degreesBox.isNotEmpty) {
      for (int i = 0; i < degreesBox.length; i++) {
        if (degreesBox.getAt(i) != null) {
          degrees.add(degreesBox.getAt(i)!);
        }
      }
    }
    if (degrees.isEmpty) {
      dataState = DataState.empty;
    } else {
      dataState = DataState.notEmpty;
    }
    update();
    super.onReady();
  }

  @override
  void onClose() {
    degreeTextController!.dispose();
    super.onClose();
  }
}
