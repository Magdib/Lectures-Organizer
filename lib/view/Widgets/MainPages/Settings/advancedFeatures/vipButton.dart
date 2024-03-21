import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unversityapp/controller/settingsPagesController/advancedFeaturesController.dart';
import 'package:unversityapp/core/Constant/static_data.dart';
import 'package:unversityapp/view/Widgets/shared/CustomButton.dart';

class VipButton extends StatelessWidget {
  const VipButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AdvancedFeaturesControllerImp>(
        builder: (controller) => AnimatedContainer(
              width: controller.isVip ? StaticData.deviceWidth : 132,
              duration: const Duration(seconds: 1),
              child: controller.isVip
                  ? Container(
                      height: 40,
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Colors.yellow, Color(0xffad9c00)],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        "النّسخة المحسّنة مفعّلة",
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: CustomButton(
                        text: "كود التفعيل",
                        onPressed: () =>
                            controller.featuresVerification(context),
                        minWidth: 60,
                        height: 40,
                        borderRadius: 10,
                        fontSize: 15,
                      ),
                    ),
            ));
  }
}
