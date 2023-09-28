import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:unversityapp/controller/MainPagesControllers/HomePageController.dart';
import 'package:unversityapp/controller/MainPagesControllers/SettingsController.dart';
import 'package:unversityapp/core/Constant/HiveData/HiveKeysBoxes.dart';
import 'package:unversityapp/core/functions/GlobalFunctions/hiveNullCheck.dart';
import 'package:unversityapp/core/functions/validation/CurrentYearFuntions.dart';
import 'package:unversityapp/view/Widgets/shared/BlueSnackBar.dart';

abstract class ProfileController extends GetxController {
  void checkSaveState();
  void addYear(bool isCurrentYear);
  void removeYear(bool isCurrentYear);
  void addSubject();
  void removeSubject();
  void saveAverage();
  void checkAverageSave();
  Future<void> saveData();
}

class ProfileControllerimp extends ProfileController {
  Box userDataBox = Hive.box(HiveBoxes.userDataBox);
  late TextEditingController nameController;
  late TextEditingController studyController;
  late TextEditingController averageController;
  bool canSave = true;
  bool canSaveAV = false;
  late int currentYear;
  late int numberOfYears;
  late bool anyDegree;
  int numberOfSubjects = 10;
  @override
  void addYear(bool isCurrentYear) {
    if (isCurrentYear && currentYear < numberOfYears) {
      currentYear++;
      update();
    } else if (isCurrentYear == false && numberOfYears < 6) {
      numberOfYears++;
      update();
    }
  }

  @override
  void removeYear(bool isCurrentYear) {
    if (isCurrentYear && currentYear > 1) {
      currentYear--;
      update();
    } else if (isCurrentYear == false &&
        numberOfYears > currentYear &&
        numberOfYears > 2) {
      numberOfYears--;
      update();
    }
  }

  @override
  void addSubject() {
    numberOfSubjects++;
    checkAverageSave();
    update();
  }

  @override
  void removeSubject() {
    if (numberOfSubjects > 0) {
      numberOfSubjects--;
      checkAverageSave();
      update();
    }
  }

  @override
  void checkAverageSave() {
    if ((averageController.text.contains("-") ||
            averageController.text.contains(" ") ||
            averageController.text.contains(",") ||
            averageController.text.isEmpty) ==
        false) {
      if (double.parse(averageController.text) > 50 &&
          double.parse(averageController.text) < 100 &&
          numberOfSubjects > 0) {
        canSaveAV = true;
      } else {
        canSaveAV = false;
      }
    } else {
      canSaveAV = false;
    }
    update();
  }

  @override
  void saveAverage() {
    userDataBox.put(HiveKeys.average, double.parse(averageController.text));
    userDataBox.put(HiveKeys.numOfSubAV, numberOfSubjects);
    userDataBox.put(HiveKeys.smartAverage, true);
    userDataBox.put(HiveKeys.anyDegree, true);
    anyDegree = true;
    Get.back();
    SettingsControllerimp settingsController = Get.find();
    Get.back();
    settingsController.getAverage(1);
    blueSnackBar("حفظ!", "تم حفظ المعدل الذكي بنجاح",
        duration: const Duration(seconds: 3));
  }

  @override
  void checkSaveState() {
    if (nameController.text.length > 1 &&
        studyController.text.length > 3 &&
        currentYear < numberOfYears) {
      canSave = true;
    } else {
      canSave = false;
    }
    update();
  }

  @override
  Future<void> saveData() async {
    HomePageControllerimp homePageController = Get.find();
    SettingsControllerimp settingsController = Get.find();
    settingsController.yearAsString =
        yearToStringfunction(currentYear, numberOfYears);
    settingsController.currentYear = currentYear;
    settingsController.numberOfYears = numberOfYears;
    settingsController.studentName = nameController.text;
    settingsController.studentStudy = studyController.text;
    String yearWord = yearWordFunction(currentYear, numberOfYears);
    await userDataBox.put(HiveKeys.currentYear, currentYear);
    await userDataBox.put(HiveKeys.yearWord, yearWord);
    await userDataBox.put(HiveKeys.numberofYears, numberOfYears);
    await userDataBox.put(HiveKeys.name, nameController.text);
    await userDataBox.put(HiveKeys.study, studyController.text);
    homePageController.yearWord = yearWord;
    homePageController.numberofYears = numberOfYears;
    settingsController.refreshYearData();
    Get.back();
  }

  @override
  void onInit() {
    nameController =
        TextEditingController(text: userDataBox.get(HiveKeys.name));
    studyController =
        TextEditingController(text: userDataBox.get(HiveKeys.study));

    averageController = TextEditingController();
    currentYear = userDataBox.get(HiveKeys.currentYear);
    numberOfYears = userDataBox.get(HiveKeys.numberofYears);
    anyDegree = hiveNullCheck(HiveKeys.anyDegree, false);
    super.onInit();
  }

  @override
  void onClose() {
    nameController.dispose();
    studyController.dispose();
    super.onClose();
  }
}
