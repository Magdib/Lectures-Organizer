import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unversityapp/core/class/HandleData.dart';

import '../../../controller/FeaturePagesControllers/LecturesSearchController.dart';

import '../../../model/HiveAdaptersModels/LecturesAdapter.dart';

class SearchBody extends StatelessWidget {
  const SearchBody({
    super.key,
    required this.query,
    required this.filtredLectures,
  });
  final String query;
  final List<LecturesPageModel> filtredLectures;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).backgroundColor,
      child: GetBuilder<LectureSearchControllerimp>(
          builder: (controller) => HandleData(
                dataState: controller.dataState,
                emptyWidget: Center(
                  child: Text(
                    textAlign: TextAlign.center,
                    'لا يوجد محاضرات',
                    style: Get.textTheme.headline1!.copyWith(fontSize: 17),
                  ),
                ),
                notEmptyWidget: ListView.builder(
                    itemCount: query == ''
                        ? controller.lectures.length
                        : controller.filterdLectrues.length,
                    itemBuilder: (context, index) => InkWell(
                          onTap: () => controller.openLecture(index, query),
                          child: Container(
                              padding: const EdgeInsets.all(20),
                              child: query == ''
                                  ? Text(
                                      controller.lectures[index].lecturename,
                                      style: Get.textTheme.headline1!
                                          .copyWith(fontSize: 17),
                                    )
                                  : Text(filtredLectures[index].lecturename,
                                      style: Get.textTheme.headline1!
                                          .copyWith(fontSize: 17))),
                        )),
              )),
    );
  }
}
