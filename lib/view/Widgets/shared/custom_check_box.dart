import 'package:flutter/material.dart';

class CustomCheckBox extends StatelessWidget {
  const CustomCheckBox({
    Key? key,
    required this.text,
    required this.onChanged,
    required this.checked,
  }) : super(key: key);
  final String text;
  final void Function()? onChanged;
  final bool checked;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        MaterialButton(
          padding: const EdgeInsets.all(0),
          splashColor: Theme.of(context).primaryColor,
          minWidth: 35,
          height: 35,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          onPressed: onChanged,
          color: checked
              ? Theme.of(context).primaryColor
              : Theme.of(context).scaffoldBackgroundColor,
          child: Icon(
            Icons.check,
            color: Theme.of(context).scaffoldBackgroundColor,
          ),
        ),
        const SizedBox(
          width: 20,
        ),
        Text(
          text,
          style: Theme.of(context).textTheme.headline2,
        )
      ],
    );
  }
}
