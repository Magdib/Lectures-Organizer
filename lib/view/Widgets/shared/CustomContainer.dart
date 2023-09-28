import 'package:flutter/material.dart';

class CustomContainer extends StatelessWidget {
  const CustomContainer({
    Key? key,
    required this.child,
    this.height,
    this.width,
    this.padding,
    this.gradient,
    this.color,
    this.circularRadius,
  }) : super(key: key);
  final Widget child;
  final double? height;
  final double? width;
  final EdgeInsetsGeometry? padding;
  final Gradient? gradient;
  final Color? color;
  final double? circularRadius;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      padding: padding,
      decoration: BoxDecoration(
          color: color ?? Theme.of(context).buttonTheme.colorScheme!.background,
          borderRadius: BorderRadius.circular(circularRadius ?? 30),
          gradient: gradient,
          border: Border.all(color: Theme.of(context).primaryColor)),
      child: child,
    );
  }
}
