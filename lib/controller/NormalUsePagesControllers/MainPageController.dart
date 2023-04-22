import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:unversityapp/controller/MainPagesControllers/StaticsPageController.dart';
import '../../core/Constant/HiveData/HiveKeysBoxes.dart';
import '../../view/screens/MainPages/HomePage.dart';
import '../../view/screens/MainPages/Settings.dart';
import '../../view/screens/MainPages/Statistics.dart';

abstract class MainPageController extends GetxController {
  void bottomBarChangePage(int page);
  void pageViewChangePage(int page);
  void handelStaticsState(int page);
}

class MainPageControllerimp extends MainPageController {
  late Box userDataBox;
  bool staticState = false;
  bool settingsState = false;
  RxInt selectedpage = 0.obs;
  PageController pageController = PageController();

  final List<Widget> pages = [
    const HomePage(),
    const Statistics(),
    const SettingsPage()
  ];

  @override
  void handelStaticsState(int page) {
    if (page == 2) {
      settingsState = true;
    } else if (page == 1) {
      if (staticState == true && settingsState == true) {
        StaticsControllerimp controller = Get.find();
        controller.getData(1);
      }
      staticState = true;
    } else {
      settingsState = false;
    }
  }

  @override
  bottomBarChangePage(int page) {
    selectedpage.value = page;
    pageController.jumpToPage(
      page,
    );

    update();
  }

  @override
  pageViewChangePage(int page) {
    selectedpage.value = page;
    handelStaticsState(page);

    update();
  }

  @override
  void onReady() async {
    if (Hive.isBoxOpen(HiveBoxes.userDataBox) == false) {
      userDataBox = await Hive.openBox(HiveBoxes.userDataBox);
    }
    super.onReady();
  }
}
