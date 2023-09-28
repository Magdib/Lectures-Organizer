import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../controller/NormalUsePagesControllers/SubjectsPageController.dart';
import '../../../../core/Constant/AppColors.dart';

class TermDropDownButton extends StatelessWidget {
  const TermDropDownButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SubjectsPageControllerimp>(
      builder: (controller) => DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          isDense: true,
          iconEnabledColor: AppColors.cyan,
          style: Theme.of(context).textTheme.headline6,
          menuMaxHeight: 180,
          dropdownColor: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: BorderRadius.circular(10),
          items: ["كِلا الفصلين", "الفصل الأول", "الفصل الثاني"]
              .map(
                (e) => DropdownMenuItem(
                  value: e,
                  child: Text(e),
                ),
              )
              .toList(),
          onChanged: (value) => controller.filterTermFunction(value!),
          value: controller.termFilter,
        ),
      ),
    );
  }
}
