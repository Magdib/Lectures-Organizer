import 'package:flutter/material.dart';
import '../../../core/Constant/AppColors.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    Key? key,
    this.hint,
    this.onchange,
    this.maxchar,
    this.editingController,
    this.label,
    this.height,
    this.width,
    this.padding,
    this.keyboardType,
    this.borderRadius,
    this.readOnly,
    this.suffixIcon,
    this.onPressedSuffix,
    this.prefixIcon,
    this.onPressedPrefix,
  }) : super(key: key);
  final String? hint;
  final String? label;
  final int? maxchar;
  final TextEditingController? editingController;
  final void Function(String value)? onchange;
  final double? height;
  final double? width;
  final EdgeInsetsGeometry? padding;
  final TextInputType? keyboardType;
  final double? borderRadius;
  final bool? readOnly;
  final IconData? suffixIcon;
  final IconData? prefixIcon;
  final VoidCallback? onPressedSuffix;
  final VoidCallback? onPressedPrefix;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: height,
        width: width,
        child: Padding(
          padding:
              padding ?? const EdgeInsets.only(top: 8.0, left: 8, right: 8),
          child: TextField(
            controller: editingController,
            cursorColor: AppColors.cyan,
            keyboardType: keyboardType,
            style: readOnly == true
                ? Theme.of(context)
                    .textTheme
                    .headline6!
                    .copyWith(color: AppColors.white)
                : Theme.of(context).textTheme.headline6,
            autofocus: false,
            maxLength: maxchar,
            onTap: () {
              if (editingController != null) {
                if (editingController!.selection ==
                    TextSelection.fromPosition(TextPosition(
                        offset: editingController!.text.length - 1))) {
                  editingController!.selection = TextSelection.fromPosition(
                      TextPosition(offset: editingController!.text.length));
                }
              }
            },
            onChanged: onchange,
            readOnly: readOnly ?? false,
            decoration: InputDecoration(
                suffixIcon: suffixIcon != null
                    ? IconButton(
                        onPressed: onPressedSuffix,
                        icon: Icon(
                          suffixIcon,
                          color: Theme.of(context).primaryColor,
                        ))
                    : null,
                prefixIcon: prefixIcon != null
                    ? IconButton(
                        onPressed: onPressedPrefix,
                        icon: Icon(
                          prefixIcon,
                          color: Theme.of(context).primaryColor,
                        ))
                    : null,
                filled: true,
                fillColor: readOnly == true
                    ? AppColors.grey
                    : Theme.of(context).scaffoldBackgroundColor,
                counterText: '',
                floatingLabelBehavior: FloatingLabelBehavior.auto,
                labelText: readOnly == true ? null : label,
                labelStyle: Theme.of(context).textTheme.headline2,
                prefixStyle: Theme.of(context).textTheme.headline4,
                hintText: hint,
                hintStyle: Theme.of(context).textTheme.bodyText2,
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(borderRadius ?? 15),
                    borderSide: BorderSide(
                        color: Theme.of(context).primaryColor, width: 2)),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(borderRadius ?? 15),
                    borderSide: BorderSide(
                        color: Theme.of(context).primaryColor, width: 2)),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(borderRadius ?? 15),
                    borderSide: BorderSide(
                        color: Theme.of(context).primaryColor, width: 2))),
          ),
        ));
  }
}
