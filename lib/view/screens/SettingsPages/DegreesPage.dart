import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unversityapp/controller/settingsPagesController/degreesPageController.dart';
import 'package:unversityapp/core/functions/Dialogs/DegreesDialog.dart';
import '../../../core/functions/ExitAndRefresh/exitRefreshDegrees.dart';
import '../../../core/Constant/AppColors.dart';
import '../../Widgets/shared/CustomAppBar.dart';
import '../../Widgets/MainPages/Settings/DegreesPage/DegreesListView.dart';

class DergreePage extends StatelessWidget {
  const DergreePage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Get.put(DegreesControllerimp());
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      floatingActionButton: FloatingActionButton(
        onPressed: () => degreesDialog(context),
        child: const Icon(Icons.add, color: AppColors.white),
      ),
      body: WillPopScope(
        onWillPop: exitRefreshDegrees,
        child: Padding(
          padding:
              const EdgeInsets.only(top: 40, left: 10, right: 10, bottom: 5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CustomAppBar(
                text: "درجات المواد",
              ),
              const SizedBox(
                height: 40,
              ),
              GetBuilder<DegreesControllerimp>(
                builder: (controller) => Text(
                  ' عدد المواد الكلي : ${controller.degrees.length}',
                  style: Theme.of(context).textTheme.headline6,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const DegreesListView()
            ],
          ),
        ),
      ),
    );
  }
}
