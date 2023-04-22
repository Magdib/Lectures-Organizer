import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../controller/FeaturePagesControllers/LecturesSearchController.dart';
import '../../../../core/Constant/AppColors.dart';
import '../../../screens/FeaturesPages/LecturesSearch.dart';

class HomePageSearchButton extends StatelessWidget {
  const HomePageSearchButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      padding: const EdgeInsets.all(0),
      height: 55,
      minWidth: double.infinity,
      splashColor: Theme.of(context).primaryColor,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
          side: const BorderSide(color: AppColors.lightblue, width: 2)),
      onPressed: () {
        LectureSearchControllerimp controller =
            Get.put(LectureSearchControllerimp());
        if (controller.where == 1) {
          controller.onReady();
        }
        showSearch(
          context: context,
          delegate: LecturesSearch(),
        );
      },
      child: Row(
        children: [
          const SizedBox(
            width: 20,
          ),
          const Icon(
            Icons.search,
            color: AppColors.lightblue,
          ),
          const SizedBox(
            width: 15,
          ),
          Text('البحث حسب المحاضرة ...',
              style: Theme.of(context).textTheme.bodyText2)
        ],
      ),
    );
  }
}
