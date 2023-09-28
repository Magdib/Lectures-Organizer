import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unversityapp/controller/NormalUsePagesControllers/SubjectsPageController.dart';
import '../../../core/Constant/ConstLists/YearsLists.dart';
import '../../../core/Constant/AppColors.dart';
import '../../../core/functions/Dialogs/subjectsDialogs.dart';
import '../../Widgets/shared/CustomAppBar.dart';
import '../../Widgets/shared/FilterTextFiled.dart';
import '../../Widgets/NormalUsePages/subjectsPage/SubjectsList.dart';
import '../../Widgets/NormalUsePages/subjectsPage/TermDropDownButton.dart';

class SubjectsPage extends StatelessWidget {
  const SubjectsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final SubjectsPageControllerimp controller =
        Get.put(SubjectsPageControllerimp());
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () => addSubjectDialog(context),
        backgroundColor:
            Theme.of(context).bottomNavigationBarTheme.backgroundColor,
        child: const Icon(Icons.add, color: AppColors.white),
      ),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: customAppBar(controller.pageyear, context),
      body: Padding(
        padding: const EdgeInsets.only(top: 20, left: 10, right: 10, bottom: 5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'نصيحة: ${randomAdviceWords[controller.random]}',
              style:
                  Theme.of(context).textTheme.bodyText2!.copyWith(fontSize: 20),
            ),
            const SizedBox(
              height: 20,
            ),
            FilterTextFiled(
                text: "المادة",
                onChanged: (value) => controller.filterList(value),
                textEditingController: controller.filterListController!),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GetBuilder<SubjectsPageControllerimp>(
                  builder: (controller) => Text(
                    'المواد: ${controller.currentYearSubjects.length}',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ),
                const TermDropDownButton(),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            const SubjectsList(),
          ],
        ),
      ),
    );
  }
}
