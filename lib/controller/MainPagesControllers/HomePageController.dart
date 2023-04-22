import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:unversityapp/core/Routes/routes.dart';

import '../../core/Constant/HiveData/HiveKeysBoxes.dart';
import '../../core/Constant/ConstLists/YearsLists.dart';

abstract class HomePageController extends GetxController {
  void nextPage(int index);
}

class HomePageControllerimp extends HomePageController {
  Box userDataBox = Hive.box(HiveBoxes.userDataBox);
  late String yearWord;
  late String studentName;
  late int numberofYears;

  @override
  void nextPage(int index) {
    Get.toNamed(AppRoutes.subjectPageRoute, arguments: {
      'year': years[index].year,
    });
  }

  @override
  void onInit() {
    yearWord = userDataBox.get(HiveKeys.yearWord);
    studentName = userDataBox.get(HiveKeys.name);
    numberofYears = userDataBox.get(HiveKeys.numberofYears);
    super.onInit();
  }
}
