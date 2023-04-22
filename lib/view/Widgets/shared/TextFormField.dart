import 'package:flutter/material.dart';
import '../../../core/Constant/AppColors.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    Key? key,
    this.hint,
    this.onchange,
    required this.maxchar,
    required this.editingController,
  }) : super(key: key);
  final String? hint;
  final int maxchar;
  final TextEditingController editingController;
  final void Function(String value)? onchange;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, left: 8, right: 8),
      child: TextField(
        controller: editingController,
        cursorColor: AppColors.cyan,
        style: Theme.of(context).textTheme.headline6,
        autofocus: false,
        maxLength: maxchar,
        onTap: () {
          if (editingController.selection ==
              TextSelection.fromPosition(
                  TextPosition(offset: editingController.text.length - 1))) {
            editingController.selection = TextSelection.fromPosition(
                TextPosition(offset: editingController.text.length));
          }
        },
        onChanged: onchange,
        decoration: InputDecoration(
            counterText: '',
            prefixStyle: Theme.of(context).textTheme.headline4,
            hintText: hint,
            hintStyle: Theme.of(context).textTheme.bodyText2,
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide(
                    color: Theme.of(context).primaryColor, width: 2)),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide(
                    color: Theme.of(context).primaryColor, width: 2)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide(
                    color: Theme.of(context).primaryColor, width: 2))),
      ),
    );
  }
}
