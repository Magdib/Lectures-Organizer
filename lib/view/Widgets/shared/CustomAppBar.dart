import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unversityapp/core/Constant/uiNumber.dart';
import 'CustomAppBarButtons.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    Key? key,
    required this.text,
  }) : super(key: key);
  final String text;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const GoToBookMarkButton(),
        Text(
          text,
          style: Theme.of(context).textTheme.headline1,
        ),
        const GoToRecentButton(),
      ],
    );
  }
}

AppBar customAppBar(String text, BuildContext context,
    {bool enableActions = true}) {
  return AppBar(
      title: Text(
        text,
        style: Theme.of(context).textTheme.headline1,
      ),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      elevation: 0,
      centerTitle: true,
      leading: enableActions
          ? const GoToBookMarkButton()
          : IconButton(
              onPressed: () => Get.back(),
              splashRadius: UINumbers.iconButtonRadius,
              icon: Icon(
                Icons.arrow_back,
                color: Theme.of(context).primaryColor,
                size: 30,
              )),
      actions: enableActions ? const [GoToRecentButton()] : null);
}
