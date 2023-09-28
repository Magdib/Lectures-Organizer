import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unversityapp/controller/NormalUsePagesControllers/LecturePageController.dart';
import 'package:unversityapp/view/Widgets/NormalUsePages/LecturesPage/LectureDropDownButton.dart';
import 'package:unversityapp/view/Widgets/shared/FilterTextFiled.dart';
import '../../../core/functions/ExitAndRefresh/exitRefreshSubjects.dart';
import '../../../core/Constant/AppColors.dart';
import '../../Widgets/NormalUsePages/LecturesPage/LecturesListView.dart';
import '../../Widgets/NormalUsePages/LecturesPage/SubjectProgress.dart';
import '../../Widgets/NormalUsePages/LecturesPage/LecturesAppBar.dart';
import '../../../core/functions/Dialogs/LecturesDialogs.dart';

class LecturesPage extends StatelessWidget {
  const LecturesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final LecturePageControllerimp controller =
        Get.put(LecturePageControllerimp());
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      floatingActionButton: FloatingActionButton(
        onPressed: () => lectureaddDialog(
          context,
        ),
        child: const Icon(Icons.add, color: AppColors.white),
      ),
      body: WillPopScope(
        onWillPop: exitRefreshSubjects,
        child: Padding(
            padding: const EdgeInsets.only(top: 40, left: 10, right: 10),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const LecturesAppBar(),
                  const SizedBox(
                    height: 30,
                  ),
                  const SubjectProgress(),
                  const SizedBox(
                    height: 5,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0, top: 2),
                    child: GetBuilder<LecturePageControllerimp>(
                      builder: (controller) => Text(
                        'نسبة التقدم في المادة: ${(controller.percent * 100).toStringAsFixed(1)}%',
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  FilterTextFiled(
                      text: "المحاضرة",
                      onChanged: (value) => controller.filterLectures(value),
                      textEditingController: controller.filterEditController!),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GetBuilder<LecturePageControllerimp>(
                        builder: (controller) => Text(
                          'المحاضرات: ${controller.currentLectures.length}',
                          style: Theme.of(context).textTheme.headline6,
                        ),
                      ),
                      const LectureDropDownButton(),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const LecturesListView(),
                ])),
      ),
    );
  }
}
