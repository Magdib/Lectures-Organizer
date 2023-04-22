import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/NormalUsePagesControllers/SubjectsPageController.dart';
import '../../../core/Constant/AppColors.dart';

class FilterTextFiled extends GetView<SubjectsPageControllerimp> {
  const FilterTextFiled({
    Key? key,
    required this.text,
    required this.onChanged,
    required this.textEditingController,
  }) : super(key: key);
  final String text;
  final void Function(String) onChanged;
  final TextEditingController textEditingController;
  @override
  Widget build(BuildContext context) {
    return TextField(
        controller: textEditingController,
        style: Theme.of(context).textTheme.headline6,
        onChanged: onChanged,
        onTap: () {
          if (textEditingController.selection ==
              TextSelection.fromPosition(TextPosition(
                  offset: textEditingController.text.length - 1))) {
            textEditingController.selection = TextSelection.fromPosition(
                TextPosition(offset: textEditingController.text.length));
          }
        },
        decoration: InputDecoration(
          hintText: 'البحث حسب $text...',
          hintStyle: Theme.of(context).textTheme.bodyText2,
          prefixIcon: const Icon(
            Icons.search,
            color: AppColors.blue,
          ),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide:
                  const BorderSide(color: AppColors.deepblue, width: 2)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide:
                  const BorderSide(color: AppColors.lightblue, width: 2)),
        ));
  }
}
