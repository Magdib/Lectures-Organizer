import 'package:flutter/material.dart';
import '../../shared/CustomContainer.dart';

class CustomSettingsListTile extends StatelessWidget {
  const CustomSettingsListTile({
    Key? key,
    required this.title,
    this.trail,
    this.contentPadding,
  }) : super(key: key);

  final String title;
  final Widget? trail;
  final EdgeInsetsGeometry? contentPadding;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomContainer(
          child: ListTile(
            contentPadding: contentPadding,
            title: Text(
              title,
              style: Theme.of(context).textTheme.bodyText1,
            ),
            trailing: trail,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }
}
