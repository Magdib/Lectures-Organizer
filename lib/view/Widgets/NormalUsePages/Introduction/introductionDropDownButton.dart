import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unversityapp/controller/NormalUsePagesControllers/introductionController.dart';

import '../../../../core/Constant/AppColors.dart';

class IntroductionDropDownButton extends GetView<IntroductionControllerimp> {
  const IntroductionDropDownButton({
    Key? key,
    required this.hintText,
    required this.onChanged,
    required this.value,
    required this.items,
    required this.enabled,
  }) : super(key: key);
  final String hintText;
  final void Function(String?)? onChanged;
  final String? value;
  final List<String>? items;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        width: MediaQuery.of(context).size.width / 2.4,
        height: 50,
        padding: const EdgeInsets.only(top: 10, bottom: 10, right: 15),
        decoration: BoxDecoration(
            border: Border.all(color: AppColors.deepblue, width: 2),
            borderRadius: BorderRadius.circular(40)),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            disabledHint: const Text(''),
            iconDisabledColor: AppColors.white,
            iconEnabledColor: enabled == true ? AppColors.cyan : null,
            style: Theme.of(context).textTheme.headline6,
            menuMaxHeight: 120,
            borderRadius: BorderRadius.circular(10),
            items: items
                ?.map(
                  (e) => DropdownMenuItem(
                    value: e,
                    child: Text(e),
                  ),
                )
                .toList(),
            onChanged: onChanged,
            value: value,
            hint: Text(hintText),
          ),
        ),
      ),
    );
  }
}
