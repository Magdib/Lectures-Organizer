import 'package:flutter/material.dart';
import 'package:unversityapp/core/Constant/AppColors.dart';
import 'package:unversityapp/core/Constant/uiNumber.dart';

class CustomButton extends StatelessWidget {
  const CustomButton(
      {super.key,
      required this.text,
      required this.onPressed,
      this.minWidth,
      this.fontSize,
      this.height});
  final String text;
  final void Function()? onPressed;
  final double? minWidth;
  final double? height;
  final double? fontSize;
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      height: height ?? 60,
      minWidth: minWidth ?? UINumbers.deviceWidth,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      color: Theme.of(context).primaryColor,
      disabledColor: AppColors.grey,
      onPressed: onPressed,
      child: Text(
        text,
        style: Theme.of(context)
            .textTheme
            .bodyText1!
            .copyWith(fontSize: fontSize ?? 20),
      ),
    );
  }
}
