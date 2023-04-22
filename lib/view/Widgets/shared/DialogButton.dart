import 'package:flutter/material.dart';

import '../../../core/Constant/uiNumber.dart';
import '../../../core/Constant/AppColors.dart';

class DialogButton extends StatelessWidget {
  const DialogButton(
      {Key? key, this.onPressed, required this.text, this.onLongPress})
      : super(key: key);
  final void Function()? onPressed;
  final void Function()? onLongPress;
  final String text;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(
          width: 10,
        ),
        MaterialButton(
          onLongPress: onLongPress,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
              side: BorderSide(color: Theme.of(context).primaryColor)),
          height: 50,
          padding: const EdgeInsets.all(0),
          minWidth: UINumbers.deviceWidth / 4,
          color: Theme.of(context).buttonTheme.colorScheme!.background,
          disabledColor: AppColors.grey,
          onPressed: onPressed,
          child: Text(
            text,
            style: Theme.of(context).textTheme.bodyText1,
          ),
        ),
        const SizedBox(
          width: 10,
        ),
      ],
    );
  }
}
