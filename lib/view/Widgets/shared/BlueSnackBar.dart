import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/Constant/AppColors.dart';

void blueSnackBar(String title, String subtitle, BuildContext context) {
  Get.snackbar(title, subtitle,
      animationDuration: const Duration(milliseconds: 800),
      backgroundColor: Theme.of(context).primaryColor,
      colorText: AppColors.white);
}
