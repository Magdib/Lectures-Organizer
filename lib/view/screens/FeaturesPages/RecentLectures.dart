import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unversityapp/controller/FeaturePagesControllers/RecentLectureController.dart';
import 'package:unversityapp/core/class/HandleData.dart';
import 'package:unversityapp/view/Widgets/shared/CustomAppBar.dart';

class RecentLectures extends StatelessWidget {
  const RecentLectures({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(RecentLecturesControllerimp());
    return Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar:
            customAppBar('المحاضرات الأخيرة', context, enableActions: false),
        body: Padding(
            padding: const EdgeInsets.only(top: 20, left: 10, right: 10),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                      child: GetBuilder<RecentLecturesControllerimp>(
                          builder: (controller) => HandleData(
                                dataState: controller.dataState,
                                emptyWidget: Center(
                                  child: Text(
                                    textAlign: TextAlign.center,
                                    'لم تدرس أي محاضرة حتى الآن.',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText2!
                                        .copyWith(fontSize: 20),
                                  ),
                                ),
                                notEmptyWidget: GridView.builder(
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 2,
                                            mainAxisSpacing: 10,
                                            crossAxisSpacing: 10),
                                    physics: const BouncingScrollPhysics(),
                                    itemCount: controller.recentLectures.length,
                                    itemBuilder: (context, index) => Padding(
                                          padding:
                                              const EdgeInsets.only(bottom: 10),
                                          child: MaterialButton(
                                            splashColor: Theme.of(context)
                                                .primaryColorDark,
                                            height: 100,
                                            color: Theme.of(context)
                                                .buttonTheme
                                                .colorScheme!
                                                .onBackground,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(30),
                                                side: BorderSide(
                                                    color: Theme.of(context)
                                                        .primaryColor)),
                                            minWidth: double.infinity,
                                            onPressed: () =>
                                                controller.openLecture(index),
                                            child: Text(
                                              controller.recentLectures[index]
                                                  .lecturename
                                                  .replaceAll(".pdf", ''),
                                              textAlign: TextAlign.center,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline3!
                                                  .copyWith(
                                                      fontSize: 16,
                                                      color: Theme.of(context)
                                                          .primaryColor),
                                            ),
                                          ),
                                        )),
                              )))
                ])));
  }
}
