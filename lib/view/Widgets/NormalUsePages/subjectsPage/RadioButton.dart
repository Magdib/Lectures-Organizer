import 'package:flutter/material.dart';

class RadioButton extends StatelessWidget {
  const RadioButton({
    Key? key,
    required this.text,
    required this.onChanged,
  }) : super(key: key);
  final String text;
  final void Function()? onChanged;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        MaterialButton(
          padding: const EdgeInsets.all(0),
          splashColor: Theme.of(context).primaryColor,
          minWidth: 35,
          height: 35,
          shape: Theme.of(context).buttonTheme.shape,
          disabledColor: Theme.of(context).primaryColor,
          onPressed: onChanged,
          color: Theme.of(context).scaffoldBackgroundColor,
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
