import 'package:flutter/material.dart';

class FeaturePageModel {
  final String title;
  final IconData icon;
  final String requiredTime;
  final int requiredTimeNum;
  bool isEnabled;
  final VoidCallback onPressed;

  FeaturePageModel(
      {required this.title,
      required this.icon,
      required this.requiredTime,
      required this.requiredTimeNum,
      this.isEnabled = false,
      required this.onPressed});
}
