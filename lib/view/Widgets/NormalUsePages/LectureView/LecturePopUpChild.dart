import 'package:flutter/material.dart';

class LecturePopUpChild extends StatelessWidget {
  const LecturePopUpChild({
    super.key,
    required this.text,
    required this.icon,
  });
  final String text;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          text,
          style: Theme.of(context).textTheme.headline2,
        ),
        const SizedBox(
          width: 10,
        ),
        Icon(
          icon,
          color: Theme.of(context).primaryColorLight,
        )
      ],
    );
  }
}
