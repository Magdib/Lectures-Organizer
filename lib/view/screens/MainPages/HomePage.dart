import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unversityapp/controller/MainPagesControllers/HomePageController.dart';

import '../../Widgets/shared/CustomAppBar.dart';
import '../../Widgets/MainPages/Home/HomePageSearchButton.dart';
import '../../Widgets/MainPages/Home/ListViewofYears.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(HomePageControllerimp());
    return Padding(
      padding: const EdgeInsets.only(top: 40, left: 10, right: 10, bottom: 10),
      child: GetBuilder<HomePageControllerimp>(
        builder: (controller) => Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CustomAppBar(text: "الصفحة الرئيسية"),
                // const HomePageAppBar(),
                const SizedBox(
                  height: 30,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'أهلاً،${controller.studentName}',
                      style: Theme.of(context).textTheme.headline4,
                    ),
                    Text(
                      controller.yearWord,
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                const HomePageSearchButton(),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  'السنوات',
                  style: Theme.of(context).textTheme.headline6,
                ),
              ],
            ),
            const ListViewofYears(),
          ],
        ),
      ),
    );
  }
}
