import 'package:get/get.dart';

import '../../Constant/AppColors.dart';

void errorSnackBar(String title, String message) {
  Get.snackbar(title, message,
      backgroundColor: AppColors.deepred,
      colorText: AppColors.white,
      duration: const Duration(seconds: 4));
}
