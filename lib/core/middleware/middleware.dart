import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Constant/HiveData/HiveKeysBoxes.dart';
import '../Routes/routes.dart';
import '../services/Services.dart';

class MiddleWare extends GetMiddleware {
  @override
  int? get priority => 1;
  Services myServices = Get.find();
  @override
  RouteSettings? redirect(String? route) {
    switch (myServices.userDataBox!.get(HiveKeys.step)) {
      case 1:
        return const RouteSettings(name: AppRoutes.mainPageRoute);
      case 2:
        return const RouteSettings(name: AppRoutes.fastModePageRoute);
      default:
        return null;
    }
  }
}
