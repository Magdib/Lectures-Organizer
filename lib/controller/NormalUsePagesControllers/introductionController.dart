import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:unversityapp/core/Routes/routes.dart';
import 'package:unversityapp/core/functions/validation/CurrentYearFuntions.dart';
import 'package:unversityapp/core/functions/validation/YearStringToInt.dart';

import '../../core/Constant/HiveData/HiveKeysBoxes.dart';

abstract class IntroductionController extends GetxController {
  void changeNumberOfYears(String val);
  void changeCurrentYear(String val);
  void enableDropDownButton();
  void checkifReady();
  void dropDownButtonFix(BuildContext context);
  void nextPage();
}

class IntroductionControllerimp extends IntroductionController {
  String? numberOfYearsItem;
  String? currentYearItem;
  int numberOfYears = 1;
  int currentyear = 0;
  String? currentYearToWord;
  late String yearword;

  TextEditingController nameController = TextEditingController();
  TextEditingController studyController = TextEditingController();
  List<String> numberofYearsList = [];
  bool isNumberOfYearsChoosen = false;
  bool isCurrentYearChoosen = false;
  bool ignorPointer = true;
  late Box userDataBox;
  bool isReady = false;

  //List Depend on what User Choose
  List<String>? currentYearList;
  @override
  changeNumberOfYears(String val) {
    if (isNumberOfYearsChoosen == false) isNumberOfYearsChoosen = true;

    numberOfYearsItem = val;
    numberOfYears = numberofYearsToInt(val);
    if (currentyear < numberOfYears) {
      currentYearList = currentYearValidation(val);
    } else {
      currentYearItem = 'السنة الأولى';
      currentYearList = ['السنة الأولى'];
      currentyear = 1;
    }
    checkifReady();
    update();
  }

  @override
  changeCurrentYear(String val) {
    if (isCurrentYearChoosen == false) isCurrentYearChoosen = true;
    currentYearItem = val;
    currentyear = currentYearStringToInt(val);
    checkifReady();
    update();
  }

  @override
  enableDropDownButton() {
    if (nameController.text.length > 2 && studyController.text.length > 3) {
      checkifReady();
      numberofYearsList = [
        'سنتين',
        'ثلاث سنوات',
        'أربع سنوات',
        'خمس سنوات',
        'ست سنوات'
      ];
      update();
    }
  }

  @override
  checkifReady() {
    if (isCurrentYearChoosen == true &&
        isNumberOfYearsChoosen == true &&
        nameController.text.length > 2 &&
        studyController.text.length > 3) {
      isReady = true;
    }
  }

  @override
  void dropDownButtonFix(BuildContext context) {
    if (nameController.text.length > 2 && studyController.text.length > 3) {
      FocusScope.of(context).unfocus();
      ignorPointer = false;
      update();
    }
  }

  @override
  void onReady() async {
    userDataBox = await Hive.openBox(HiveBoxes.userDataBox);
    super.onReady();
  }

  @override
  void onClose() {
    nameController.dispose();
    studyController.dispose();
    super.onClose();
  }

  @override
  void nextPage() {
    userDataBox.put(HiveKeys.name, nameController.text);
    userDataBox.put(HiveKeys.study, studyController.text);
    userDataBox.put(HiveKeys.numberofYears, numberOfYears);
    userDataBox.put(HiveKeys.currentYear, currentyear);
    currentYearToWord = yearToStringfunction(currentyear, numberOfYears);
    yearword = yearWordFunction(currentyear, numberOfYears);
    userDataBox.put(HiveKeys.currentYearToWord, currentYearToWord);
    userDataBox.put(HiveKeys.yearWord, yearword);
    userDataBox.put(HiveKeys.step, 1);
    Get.offAllNamed(AppRoutes.mainPageRoute);
  }
}
