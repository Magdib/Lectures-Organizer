import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unversityapp/controller/settingsPagesController/app_data_controllers/app_data_controller.dart';
import 'package:unversityapp/core/Constant/AppColors.dart';
import 'package:unversityapp/view/Widgets/MainPages/Settings/CustomSettingsListTile.dart';

class AppStyleColumn extends StatelessWidget {
  const AppStyleColumn({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "المظهر:",
          style: Theme.of(context).textTheme.headline2!.copyWith(fontSize: 22),
        ),
        const SizedBox(
          height: 10,
        ),
        GetBuilder<AppDataController>(
          builder: (controller) => CustomSettingsListTile(
              title: "تغيير المظهر التلقائي",
              contentPadding: const EdgeInsets.only(left: 7.5, right: 15),
              trail: Switch(
                value: controller.automaticTheme,
                onChanged: (val) {
                  controller.changeAutomaticThemeState(val);
                },
                activeColor: AppColors.black,
                activeTrackColor: AppColors.green,
              )),
        ),
        Text(
          "عند تفعيل هذا الخيار سيقوم التطبيق بتفعيل الوضع الليلي تلقائياً عند تجاوز الساعة الخامسة مساءً حتى الساعة السابعة صباحاً.",
          style: Theme.of(context).textTheme.bodyText2!.copyWith(fontSize: 12),
        ),
        const SizedBox(
          height: 30,
        ),
      ],
    );
  }
}
