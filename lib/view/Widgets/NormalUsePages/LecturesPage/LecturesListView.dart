import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unversityapp/core/class/HandleData.dart';
import 'package:unversityapp/core/functions/Dialogs/LecturesDialogs.dart';

import '../../../../controller/NormalUsePagesControllers/LecturePageController.dart';
import '../../../../core/Constant/static_data.dart';
import '../../shared/EmptyPageContent.dart';
import 'BookMarkIconState.dart';

class LecturesListView extends StatelessWidget {
  const LecturesListView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: GetBuilder<LecturePageControllerimp>(
            builder: (controller) => HandleData(
                dataState: controller.dataState,
                emptyWidget: const EmptyPage(
                  whatisempty: 'محاضرات',
                  whatisempty1: 'محاضرة',
                ),
                notEmptyWidget: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: controller.currentLectures.length,
                  itemBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Stack(
                      children: [
                        Container(
                          width: double.infinity,
                          height: 60,
                          decoration: BoxDecoration(
                              color: controller.currentLectures[index].check ||
                                      controller.currentLectures[index].chosen
                                  ? Theme.of(context)
                                      .floatingActionButtonTheme
                                      .backgroundColor
                                  : null,
                              borderRadius: BorderRadius.circular(30),
                              border: Border.all(
                                  color: Theme.of(context).primaryColor)),
                          child: InkWell(
                            splashColor: Theme.of(context).primaryColor,
                            borderRadius: BorderRadius.circular(30),
                            onDoubleTap: () =>
                                lectureDataDialog(context, index),
                            onTap: () => controller.handleLecturesTap(index),
                            onLongPress: controller.canComplete == true
                                ? () => controller.completeLecture(index)
                                : null,
                            child: Center(
                              child: Text(
                                controller.currentLectures[index].lecturename
                                            .length >
                                        34
                                    ? controller
                                        .currentLectures[index].lecturename
                                        .replaceRange(30, null, "")
                                    : controller
                                        .currentLectures[index].lecturename
                                        .replaceAll('.pdf', ''),
                                style: controller
                                            .currentLectures[index].check ||
                                        controller.currentLectures[index].chosen
                                    ? Theme.of(context).textTheme.bodyText1
                                    : Theme.of(context)
                                        .textTheme
                                        .headline1!
                                        .copyWith(fontSize: 15),
                                maxLines: 1,
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                            right: 2,
                            top: 2.5,
                            child: IconButton(
                                onPressed: () =>
                                    controller.addToBookMark(index),
                                iconSize: 25,
                                color: Theme.of(context).primaryColor,
                                splashRadius: StaticData.iconButtonRadius,
                                icon: BookMarkIconState(
                                  completed:
                                      controller.currentLectures[index].check,
                                  marked: controller
                                      .currentLectures[index].bookMarked,
                                )))
                      ],
                    ),
                  ),
                ))));
  }
}
