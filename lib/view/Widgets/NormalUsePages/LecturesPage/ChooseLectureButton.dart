import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../controller/NormalUsePagesControllers/LecturePageController.dart';
import '../../../../core/Constant/AppColors.dart';
import '../../../../core/class/enums/ChooseIconState.dart';

class ChooseLectureButton extends GetView<LecturePageControllerimp> {
  const ChooseLectureButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SizedBox(
          width: 20,
        ),
        Text(
          "تحديد الملف :",
          style: Theme.of(context).textTheme.headline1!.copyWith(fontSize: 15),
        ),
        const SizedBox(
          width: 5,
        ),
        MaterialButton(
          onPressed: () => controller.pickLectures(),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
              side:
                  BorderSide(color: Theme.of(context).primaryColor, width: 2)),
          height: 50,
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
          splashColor: Theme.of(context).primaryColor,
          disabledColor: AppColors.grey,
          child: Text(
            "أستعراض",
            style: Theme.of(context).textTheme.headline2,
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        GetBuilder<LecturePageControllerimp>(
          builder: (controller) =>
              controller.iconState == ChooseIconState.completed
                  ? Icon(
                      Icons.check,
                      color: AppColors.deepGreen,
                    )
                  : controller.iconState == ChooseIconState.loading
                      ? SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            color: Theme.of(context).primaryColor,
                          ))
                      : SizedBox(),
        )
      ],
    );
  }
}
