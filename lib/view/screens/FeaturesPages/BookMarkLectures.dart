import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unversityapp/core/class/HandleData.dart';
import 'package:unversityapp/view/Widgets/shared/CustomAppBar.dart';
import '../../../controller/FeaturePagesControllers/BookMarkController.dart';
import '../../../core/Constant/AppColors.dart';

class BookMark extends StatelessWidget {
  const BookMark({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(BookMarkControllerimp());
    return Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: customAppBar('المحفوظات', context, enableActions: false),
        body: Padding(
            padding: const EdgeInsets.only(top: 20, left: 10, right: 10),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                      child: GetBuilder<BookMarkControllerimp>(
                          builder: (controller) => HandleData(
                                dataState: controller.dataState,
                                emptyWidget: Center(
                                  child: Text(
                                    textAlign: TextAlign.center,
                                    'لا يوجد محاضرات محفوظة',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText2!
                                        .copyWith(fontSize: 20),
                                  ),
                                ),
                                notEmptyWidget: ListView.builder(
                                    itemCount:
                                        controller.bookMarkedLectures.length,
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Dismissible(
                                          onDismissed:
                                              (DismissDirection direction) =>
                                                  controller
                                                      .removeLecture(index),
                                          key: UniqueKey(),
                                          background: Container(
                                            decoration: BoxDecoration(
                                              color: AppColors.deepred,
                                              borderRadius:
                                                  BorderRadius.circular(30),
                                            ),
                                            child: const Icon(
                                                Icons.delete_forever_outlined,
                                                color: AppColors.white),
                                          ),
                                          child: MaterialButton(
                                            onPressed: () =>
                                                controller.openLecture(index),
                                            splashColor: Theme.of(context)
                                                .primaryColorDark,
                                            minWidth: double.infinity,
                                            height: 60,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(30),
                                                side: BorderSide(
                                                    color: Theme.of(context)
                                                        .primaryColor)),
                                            child: Text(
                                              controller
                                                  .bookMarkedLectures[index]
                                                  .lecturename
                                                  .replaceAll('.pdf', ''),
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline1!
                                                  .copyWith(fontSize: 15),
                                              maxLines: 1,
                                            ),
                                          ),
                                        ),
                                      );
                                    }),
                              ))),
                ])));
  }
}
