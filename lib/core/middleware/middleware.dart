import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

import '../Constant/HiveData/HiveKeysBoxes.dart';
import '../Routes/routes.dart';
import '../services/Services.dart';

class MiddleWare extends GetMiddleware {
  @override
  int? get priority => 1;
  Services myServices = Get.find();
  @override
  RouteSettings? redirect(String? route) {
    if (myServices.userDataBox!.get(HiveKeys.name) != null) {
      return const RouteSettings(name: AppRoutes.mainPageRoute);
    } else {}
  }
}
