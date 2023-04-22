import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/Constant/uiNumber.dart';
import '../../screens/FeaturesPages/LecturesSearch.dart';

class FeaturePagesAppBar extends StatelessWidget {
  const FeaturePagesAppBar({
    super.key,
    required this.text,
  });
  final String text;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
            onPressed: () => Get.back(),
            splashRadius: UINumbers.iconButtonRadius,
            icon: Icon(
              Icons.arrow_back,
              color: Theme.of(context).primaryColor,
              size: 30,
            )),
        Text(text, style: Theme.of(context).textTheme.headline1),
        IconButton(
            onPressed: () {
              showSearch(context: context, delegate: LecturesSearch());
            },
            splashRadius: UINumbers.iconButtonRadius,
            icon: Icon(
              Icons.search,
              color: Theme.of(context).primaryColor,
              size: 30,
            )),
      ],
    );
  }
}
