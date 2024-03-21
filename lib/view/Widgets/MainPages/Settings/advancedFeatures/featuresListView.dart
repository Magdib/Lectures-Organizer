import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unversityapp/controller/settingsPagesController/advancedFeaturesController.dart';
import 'package:unversityapp/core/Constant/AppColors.dart';
import 'package:unversityapp/core/Constant/static_data.dart';

class FeaturesListView extends StatelessWidget {
  const FeaturesListView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GetBuilder<AdvancedFeaturesControllerImp>(
        builder: (controller) => ListView.separated(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          itemCount: controller.advancedFeaturesList.length,
          separatorBuilder: (context, index) => const SizedBox(
            height: 15,
          ),
          itemBuilder: (context, index) => Stack(
            children: [
              Opacity(
                opacity:
                    controller.advancedFeaturesList[index].isEnabled ? 1 : 0.7,
                child: MaterialButton(
                    onPressed: controller.advancedFeaturesList[index].isEnabled
                        ? controller.advancedFeaturesList[index].onPressed
                        : null,
                    height: 80,
                    color: Theme.of(context).scaffoldBackgroundColor,
                    disabledColor: AppColors.lightBlack,
                    shape: RoundedRectangleBorder(
                        side: BorderSide(
                            color: Theme.of(context).primaryColor, width: 2),
                        borderRadius: BorderRadius.circular(15)),
                    minWidth: StaticData.deviceWidth,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          controller.advancedFeaturesList[index].title,
                          style: Theme.of(context)
                              .textTheme
                              .headline1!
                              .copyWith(
                                  fontSize: 15,
                                  color: controller
                                          .advancedFeaturesList[index].isEnabled
                                      ? null
                                      : AppColors.white),
                        ),
                        if (controller.advancedFeaturesList[index].isEnabled)
                          Icon(controller.advancedFeaturesList[index].icon,
                              color: Theme.of(context).primaryColor)
                      ],
                    )),
              ),
              if (!controller.advancedFeaturesList[index].isEnabled)
                Positioned(
                    top: 0,
                    left: 0,
                    child: Banner(
                      message:
                          controller.advancedFeaturesList[index].requiredTime,
                      location: BannerLocation.topEnd,
                      textStyle: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .copyWith(fontSize: 12.5),
                      color: AppColors.black,
                    ))
            ],
          ),
        ),
      ),
    );
  }
}
