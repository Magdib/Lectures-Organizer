import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unversityapp/controller/NormalUsePagesControllers/MainPageController.dart';
import 'package:unversityapp/core/functions/Dialogs/ExitDialog.dart';
import '../../../core/Constant/AppColors.dart';

class MainPage extends StatelessWidget {
  MainPage({Key? key}) : super(key: key);

  final MainPageControllerimp controller = Get.put(MainPageControllerimp());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MainPageControllerimp>(
      builder: (controller) => Scaffold(
        bottomNavigationBar: GetBuilder<MainPageControllerimp>(
            builder: (controller) => CurvedNavigationBar(
                  items: const [
                    Icon(
                      Icons.home,
                      color: AppColors.lightgrey,
                    ),
                    Icon(
                      Icons.bar_chart,
                      color: AppColors.lightgrey,
                    ),
                    Icon(
                      Icons.settings,
                      color: AppColors.lightgrey,
                    )
                  ],
                  backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                  animationDuration: const Duration(milliseconds: 500),
                  color: Theme.of(context)
                      .bottomNavigationBarTheme
                      .backgroundColor!,
                  index: controller.selectedpage.value,
                  onTap: (page) => controller.bottomBarChangePage(page),
                )),
        body: PopScope(
          canPop: false,
          onPopInvoked: (didPop) => exitAppDialog(),
          child: PageView.builder(
            controller: controller.pageController,
            onPageChanged: (page) => controller.pageViewChangePage(page),
            itemBuilder: (context, index) => controller.pages[index],
            itemCount: controller.pages.length,
          ),
        ),
      ),
    );
  }
}
