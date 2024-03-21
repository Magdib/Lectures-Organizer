import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unversityapp/core/Constant/static_data.dart';
import 'package:unversityapp/core/class/enums/lectures_dial_state.dart';

import '../../../../controller/NormalUsePagesControllers/LecturePageController.dart';
import '../../../../core/functions/Dialogs/LecturesDialogs.dart';

class LecturesAppBar extends StatelessWidget {
  const LecturesAppBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LecturePageControllerimp>(
      builder: (controller) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          controller.lecturesDialState == LecturesDialState.none
              ? IconButton(
                  onPressed: () {
                    controller.handelDSTap();
                    deleteLectureDialog(context);
                  },
                  splashRadius: StaticData.iconButtonRadius,
                  icon: Icon(
                    Icons.delete_outline,
                    color: Theme.of(context).primaryColor,
                    size: 30,
                  ))
              : const SizedBox(),
          controller.subjectname.length > 8
              ? SizedBox(
                  width: StaticData.deviceWidth / 2,
                  child: FittedBox(
                    child: Text(
                      controller.subjectname,
                      style: Theme.of(context).textTheme.headline1,
                    ),
                  ),
                )
              : Text(
                  controller.subjectname,
                  style: Theme.of(context).textTheme.headline1,
                ),
          controller.lecturesDialState == LecturesDialState.none
              ? IconButton(
                  onPressed: () => controller.shareSubject(),
                  splashRadius: StaticData.iconButtonRadius,
                  icon: Icon(
                    Icons.share_outlined,
                    color: Theme.of(context).primaryColor,
                    size: 30,
                  ))
              : const SizedBox(),
        ],
      ),
    );
  }
}
