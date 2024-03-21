import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:unversityapp/controller/settingsPagesController/app_data_controllers/app_data_controller.dart';
import 'package:unversityapp/core/class/enums/data_back_up_state.dart';

class AppDataLoading extends StatelessWidget {
  const AppDataLoading({
    super.key,
    required this.widget,
  });
  final Widget widget;
  @override
  Widget build(BuildContext context) {
    return GetBuilder<AppDataController>(
      builder: (controller) => controller.dataBackUpState ==
              DataBackUpState.none
          ? widget
          : Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text(
                controller.dataBackUpState == DataBackUpState.gettingData
                    ? "جارٍ إستعادة البيانات الرجاء عدم إغلاق التطبيق"
                    : controller.dataBackUpState == DataBackUpState.backingUp
                        ? "جارٍ نسخ البيانات أحتياطياً الرجاء عدم إغلاق التطبيق"
                        : "جارٍ تحضير البيانات للمشاركة الرجاء الإنتظار...",
                style: Theme.of(context).textTheme.bodyText2,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  SpinKitPouringHourGlass(
                    color: Theme.of(context).primaryColorLight,
                    size: 50.0,
                  ),
                ],
              )
            ]),
    );
  }
}
