import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unversityapp/controller/NormalUsePagesControllers/LecturePageController.dart';

import '../../../../core/Constant/AppColors.dart';

class LectureDropDownButton extends StatelessWidget {
  const LectureDropDownButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LecturePageControllerimp>(
      builder: (controller) => DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          isDense: true,
          iconEnabledColor: AppColors.cyan,
          style: Theme.of(context).textTheme.headline6,
          menuMaxHeight: 180,
          dropdownColor: Theme.of(context).backgroundColor,
          borderRadius: BorderRadius.circular(10),
          items: ["الكل", "نظري", "عملي"]
              .map(
                (e) => DropdownMenuItem(
                  value: e,
                  child: Text(e),
                ),
              )
              .toList(),
          onChanged: (value) => controller.filterTypeFun(value!),
          value: controller.lectureType,
        ),
      ),
    );
  }
}
