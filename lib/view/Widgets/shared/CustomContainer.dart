import 'package:flutter/material.dart';

class CustomContainer extends StatelessWidget {
  const CustomContainer({
    Key? key,
    required this.child,
    this.height,
    this.width,
  }) : super(key: key);
  final Widget child;
  final double? height;
  final double? width;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
          color: Theme.of(context).buttonTheme.colorScheme!.background,
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: Theme.of(context).primaryColor)),
      child: child,
    );
  }
}
