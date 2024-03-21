import 'package:flutter/material.dart';

import '../../../../core/Constant/AppColors.dart';

class SettingsButton extends StatelessWidget {
  const SettingsButton({
    super.key,
    required this.text,
    required this.icon,
    required this.onPressed,
  });
  final String text;
  final IconData icon;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MaterialButton(
            height: 55,
            color: Theme.of(context).buttonTheme.colorScheme!.background,
            onPressed: onPressed,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(text, style: Theme.of(context).textTheme.bodyText1!),
                Icon(
                  icon,
                  size: 30,
                  color: AppColors.cyan,
                ),
              ],
            )),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }
}
