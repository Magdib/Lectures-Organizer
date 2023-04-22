import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unversityapp/controller/MainPagesControllers/StaticsPageController.dart';

import 'package:unversityapp/view/Widgets/shared/CustomContainer.dart';

import '../../Widgets/MainPages/Static/CustomProgress.dart';

class Statistics extends StatelessWidget {
  const Statistics({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final StaticsControllerimp controller = Get.put(StaticsControllerimp());
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
            padding:
                const EdgeInsets.only(top: 20, left: 10, right: 10, bottom: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    'الإحصائيات',
                    style: Theme.of(context).textTheme.headline1,
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                CustomContainer(
                  height: 70,
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20, right: 10),
                    child: GetBuilder<StaticsControllerimp>(
                      builder: (controller) => RichText(
                        text: TextSpan(children: <TextSpan>[
                          TextSpan(
                            text: "المستوى الدراسي :",
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(fontSize: 20),
                          ),
                          TextSpan(
                            text: controller.studyState,
                            style: Theme.of(context)
                                .textTheme
                                .headline3!
                                .copyWith(color: controller.studyStateColor),
                          )
                        ]),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                GridView.builder(
                  itemCount: controller.progressList.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, childAspectRatio: 0.8),
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) =>
                      GetBuilder<StaticsControllerimp>(
                    builder: (controller) => CustomProgress(
                        title: controller.progressList[index].title,
                        center: controller.progressList[index].centerText,
                        circlepercent:
                            controller.progressList[index].circlePercent,
                        fontsize: controller.progressList[index].fontSizeFix,
                        circleColor:
                            controller.progressList[index].circleColor),
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
