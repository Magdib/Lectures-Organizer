import 'package:flutter/material.dart';
import 'package:unversityapp/core/Constant/AppColors.dart';
import 'package:unversityapp/core/Constant/static_data.dart';

class CustomButton extends StatelessWidget {
  const CustomButton(
      {super.key,
      required this.text,
      required this.onPressed,
      this.minWidth,
      this.fontSize,
      this.height,
      this.borderRadius,
      this.disabledColor,
      this.color,
      this.fontColor});
  final String text;
  final void Function()? onPressed;
  final double? minWidth;
  final double? height;
  final double? fontSize;
  final double? borderRadius;
  final Color? disabledColor;
  final Color? color;
  final Color? fontColor;
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      height: height ?? 60,
      minWidth: minWidth ?? StaticData.deviceWidth,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            borderRadius ?? 17.5,
          ),
          side: color != null
              ? BorderSide(color: Theme.of(context).primaryColor)
              : BorderSide.none),
      color: color ?? Theme.of(context).primaryColor,
      disabledColor: disabledColor ?? AppColors.grey,
      onPressed: onPressed,
      child: Text(
        text,
        style: Theme.of(context)
            .textTheme
            .bodyText1!
            .copyWith(fontSize: fontSize ?? 20, color: fontColor),
      ),
    );
  }
}
