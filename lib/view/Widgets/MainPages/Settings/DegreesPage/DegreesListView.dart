import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../controller/settingsPagesController/degreesPageController.dart';
import '../../../../../core/Constant/AppColors.dart';
import '../../../../../core/class/HandleData.dart';
import '../../../shared/CustomContainer.dart';

class DegreesListView extends GetView<DegreesControllerimp> {
  const DegreesListView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DegreesControllerimp>(
        builder: (controller) => Expanded(
            child: HandleData(
                dataState: controller.dataState,
                emptyWidget: Center(
                  child: Text(
                    textAlign: TextAlign.center,
                    'لا يوجد أي درجات للمواد',
                    style: Theme.of(context)
                        .textTheme
                        .bodyText2!
                        .copyWith(fontSize: 20),
                  ),
                ),
                notEmptyWidget: ListView.builder(
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: CustomContainer(
                          height: 100,
                          child: ListTile(
                            title: Text(
                              controller.degrees[index].subjectName,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(fontSize: 20),
                            ),
                            subtitle: Padding(
                              padding: const EdgeInsets.only(top: 4.0),
                              child: Text(
                                  'الدرجة : ${controller.degrees[index].degree}',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .copyWith(
                                          fontSize: 17,
                                          fontWeight: FontWeight.normal)),
                            ),
                            trailing: IconButton(
                                onPressed: () => controller.deleteDegree(index),
                                icon: const Icon(
                                  Icons.delete,
                                  color: AppColors.white,
                                )),
                          ),
                        ),
                      );
                    },
                    itemCount: controller.degrees.length))));
  }
}
