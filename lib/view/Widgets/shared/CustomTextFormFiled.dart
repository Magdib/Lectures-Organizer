import 'package:flutter/material.dart';
import 'package:unversityapp/core/Constant/AppColors.dart';

class CustomTextFormFiled extends StatelessWidget {
  const CustomTextFormFiled({
    super.key,
    this.hint,
    this.onChanged,
    this.maxChar,
    required this.editingController,
    this.label,
    this.height,
    this.width,
    this.padding,
    this.keyboardType,
    this.validator,
  });
  final String? hint;
  final String? label;
  final int? maxChar;
  final TextEditingController editingController;
  final Function(String?)? onChanged;
  final String? Function(String?)? validator;
  final double? height;
  final double? width;
  final EdgeInsetsGeometry? padding;
  final TextInputType? keyboardType;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: editingController,
      cursorColor: AppColors.cyan,
      keyboardType: keyboardType,
      style: Theme.of(context).textTheme.headline6,
      autofocus: false,
      maxLength: maxChar,
      onTap: () {
        if (editingController.selection ==
            TextSelection.fromPosition(
                TextPosition(offset: editingController.text.length - 1))) {
          editingController.selection = TextSelection.fromPosition(
              TextPosition(offset: editingController.text.length));
        }
      },
      validator: validator,
      onChanged: onChanged,
      decoration: InputDecoration(
          counterText: '',
          floatingLabelBehavior: FloatingLabelBehavior.auto,
          labelText: label,
          labelStyle: Theme.of(context).textTheme.headline2,
          prefixStyle: Theme.of(context).textTheme.headline4,
          hintText: hint,
          hintStyle: Theme.of(context).textTheme.bodyText2,
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide:
                  BorderSide(color: Theme.of(context).primaryColor, width: 2)),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide:
                  BorderSide(color: Theme.of(context).primaryColor, width: 2)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide:
                  BorderSide(color: Theme.of(context).primaryColor, width: 2))),
    );
  }
}
