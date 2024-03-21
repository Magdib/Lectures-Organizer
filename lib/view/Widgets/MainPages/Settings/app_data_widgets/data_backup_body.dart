import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unversityapp/controller/settingsPagesController/app_data_controllers/app_data_controller.dart';
import 'package:unversityapp/view/Widgets/shared/CustomButton.dart';

class DataBackUpBody extends GetView<AppDataController> {
  const DataBackUpBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "نسخ البيانات أحتياطيّاً",
              style: Theme.of(context).textTheme.bodyText2,
            ),
            GetBuilder<AppDataController>(
              builder: (controller) => CustomButton(
                text: controller.anyBackUp ? "إستبدال" : "نسخ",
                onPressed: () => controller.dataBackUp(),
                minWidth: 100,
                height: 40,
                borderRadius: 8,
                fontSize: 16,
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "إستعادة آخر نسخة من البيانات",
              style: Theme.of(context).textTheme.bodyText2,
            ),
            CustomButton(
              text: "إستعادة",
              onPressed: () => controller.getBackUp(),
              minWidth: 100,
              height: 40,
              borderRadius: 8,
              fontSize: 16,
            ),
          ],
        ),
      ],
    );
  }
}
