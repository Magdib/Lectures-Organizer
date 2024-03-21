import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:unversityapp/core/Routes/routes.dart';
import '../../core/Constant/HiveData/HiveKeysBoxes.dart';
import '../../core/Constant/ConstLists/YearsLists.dart';

abstract class HomePageController extends GetxController {
  void nextPage(int index);
  void getData(bool refresh);
}

class HomePageControllerimp extends HomePageController {
  late Box userDataBox;
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
  void getData(refresh) {
    userDataBox = Hive.box(HiveBoxes.userDataBox);
    yearWord = userDataBox.get(HiveKeys.yearWord);
    studentName = userDataBox.get(HiveKeys.name);
    numberofYears = userDataBox.get(HiveKeys.numberofYears);
    if (refresh) {
      update();
    }
  }

  @override
  void onInit() {
    getData(false);
    super.onInit();
  }
}
