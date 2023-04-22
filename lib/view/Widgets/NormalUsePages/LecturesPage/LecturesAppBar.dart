import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unversityapp/core/Constant/uiNumber.dart';

import '../../../../controller/NormalUsePagesControllers/LecturePageController.dart';
import '../../../../core/functions/Dialogs/LecturesDialogs.dart';

class LecturesAppBar extends GetView<LecturePageControllerimp> {
  const LecturesAppBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
            onPressed: () {
              controller.handelDSTap();
              deleteLectureDialog(context);
            },
            splashRadius: UINumbers.iconButtonRadius,
            icon: Icon(
              Icons.delete_outline,
              color: Theme.of(context).primaryColor,
              size: 30,
            )),
        controller.subjectname.length > 8
            ? SizedBox(
                width: UINumbers.deviceWidth / 2,
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
        IconButton(
            onPressed: () => controller.shareSubject(),
            splashRadius: UINumbers.iconButtonRadius,
            icon: Icon(
              Icons.share_outlined,
              color: Theme.of(context).primaryColor,
              size: 30,
            )),
      ],
    );
  }
}
