import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unversityapp/controller/NormalUsePagesControllers/LectureViewController.dart';
import 'package:unversityapp/core/Constant/AppColors.dart';
import 'package:unversityapp/core/Constant/static_data.dart';
import 'package:unversityapp/core/functions/ExitAndRefresh/exitRefreshBookMark.dart';
import 'package:unversityapp/core/functions/ExitAndRefresh/exitRefreshLecture.dart';
import 'package:unversityapp/core/functions/ExitAndRefresh/exitRefreshRecent.dart';

import 'LecturePopUpMenu.dart';

class ViewAppBar extends StatelessWidget {
  const ViewAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LectureViewControllerImp>(
      builder: (controller) => AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        height: controller.appBarHeight,
        color: Theme.of(context).floatingActionButtonTheme.backgroundColor,
        child: Row(
          mainAxisAlignment: controller.where != 4
              ? MainAxisAlignment.spaceBetween
              : MainAxisAlignment.start,
          children: [
            IconButton(
                onPressed: () => controller.where == 0
                    ? exitRefreshLecture()
                    : controller.where == 1
                        ? exitRefreshBookMark()
                        : controller.where == 2
                            ? exitRefreshRecent()
                            : exitLecture(),
                icon: const Icon(
                  Icons.arrow_back,
                  color: AppColors.white,
                )),
            SizedBox(
              width: StaticData.deviceWidth - 120,
              child: Text(
                controller.lecturename.replaceAll('.pdf', ''),
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(fontSize: 15),
              ),
            ),
            if (controller.where != 4) const LecturePopUpMenu()
          ],
        ),
      ),
    );
  }
}
