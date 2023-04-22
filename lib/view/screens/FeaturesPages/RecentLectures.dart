import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unversityapp/controller/FeaturePagesControllers/RecentLectureController.dart';
import 'package:unversityapp/core/class/HandleData.dart';
import 'package:unversityapp/view/Widgets/FeaturesPages/FeaturePagesAppBar.dart';

class RecentLectures extends StatelessWidget {
  const RecentLectures({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(RecentLecturesControllerimp());
    return Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        body: Padding(
            padding: const EdgeInsets.only(top: 40, left: 10, right: 10),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const FeaturePagesAppBar(text: 'المحاضرات الأخيرة'),
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
                                notEmptyWidget: ListView.builder(
                                    reverse: true,
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
                                                .background,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(30),
                                                side: BorderSide(
                                                    color: Theme.of(context)
                                                        .primaryColor)),
                                            padding: const EdgeInsets.only(
                                                bottom: 15),
                                            minWidth: double.infinity,
                                            onPressed: () =>
                                                controller.openLecture(index),
                                            child: ListTile(
                                              title: Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 10.0),
                                                child: Text(
                                                  'المحاضرة: ${controller.recentLectures[index].lecturename.replaceAll(".pdf", '')}',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .headline3,
                                                ),
                                              ),
                                              subtitle: Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 4.0),
                                                child: Text(
                                                  'تاريخ الدراسة: ${controller.recentLectures[index].time.toString().replaceRange(10, null, '')}\nوقت الدراسة: ${controller.recentLectures[index].time.toString().replaceRange(0, 10, '').replaceRange(9, null, '')}',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyText1!
                                                      .copyWith(
                                                          fontSize: 17,
                                                          fontWeight: FontWeight
                                                              .normal),
                                                ),
                                              ),
                                            ),
                                          ),
                                        )),
                              )))
                ])));
  }
}
