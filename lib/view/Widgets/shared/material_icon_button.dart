import 'package:flutter/material.dart';
import 'package:unversityapp/core/Constant/static_data.dart';

class MaterialIconButton extends StatelessWidget {
  const MaterialIconButton(
      {super.key,
      required this.onPressed,
      required this.icon,
      required this.text});
  final VoidCallback onPressed;
  final IconData icon;
  final String text;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MaterialButton(
          height: 60,
          minWidth: 60,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                17.5,
              ),
              side:
                  BorderSide(color: Theme.of(context).primaryColor, width: 2)),
          color: Theme.of(context).scaffoldBackgroundColor,
          onPressed: onPressed,
          child: Icon(
            icon,
            color: Theme.of(context).primaryColor,
            size: 30,
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        Text(
          text,
          style: Theme.of(context).textTheme.headline1!.copyWith(fontSize: 20),
        ),
      ],
    );
  }
}
