import 'package:flutter/material.dart';
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
