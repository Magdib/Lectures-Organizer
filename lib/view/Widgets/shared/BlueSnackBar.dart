import 'package:get/get.dart';

import '../../../core/Constant/AppColors.dart';

void blueSnackBar(String title, String subtitle, {Duration? duration}) {
  Get.snackbar(title, subtitle,
      animationDuration: const Duration(milliseconds: 800),
      duration: duration,
      backgroundColor: Get.theme.primaryColor,
      colorText: AppColors.white);
}
