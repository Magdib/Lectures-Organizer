import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:unversityapp/core/Constant/AppColors.dart';

class AppToasts {
  static showErrorToast(String message) => Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 3,
      backgroundColor: AppColors.deepred,
      textColor: Colors.white,
      fontSize: 16.0);
  static Future<bool?> successToast(String message) {
    return Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 3,
        backgroundColor: Get.theme.primaryColor,
        textColor: AppColors.white,
        fontSize: 16.0);
  }
}
