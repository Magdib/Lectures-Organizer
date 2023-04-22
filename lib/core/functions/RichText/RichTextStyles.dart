import 'package:flutter/material.dart';

TextSpan richTextBlue(BuildContext context, text) {
  return TextSpan(
      text: text,
      style: Theme.of(context).textTheme.headline1!.copyWith(fontSize: 20));
}

TextSpan richTextBlack(BuildContext context, text) {
  return TextSpan(
      text: text,
      style: Theme.of(context).textTheme.headline2!.copyWith(fontSize: 14));
}

TextSpan richTextDBlack(BuildContext context, text) {
  return TextSpan(
      text: text,
      style: Theme.of(context)
          .textTheme
          .headline2!
          .copyWith(fontSize: 16, fontWeight: FontWeight.bold));
}

TextSpan richTextGrey(BuildContext context, String text) {
  return TextSpan(
      text: "$text:\n\n",
      style: Theme.of(context).textTheme.bodyText2!.copyWith(fontSize: 20));
}
