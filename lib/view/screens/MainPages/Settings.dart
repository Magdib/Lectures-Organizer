import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unversityapp/core/Routes/routes.dart';
import '../../../controller/MainPagesControllers/SettingsController.dart';
import '../../../core/Constant/AppColors.dart';
import '../../Widgets/MainPages/Settings/CustomSettingsListTile.dart';
import '../../Widgets/MainPages/Settings/GreyDivider.dart';
import '../../Widgets/MainPages/Settings/SettingsButton.dart';
import '../SettingsPages/DegreesPage.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final SettingsControllerimp controller = Get.put(SettingsControllerimp());
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'البيانات الشخصية : ',
                style: Theme.of(context).textTheme.headline2,
              ),
              const SizedBox(
                height: 10,
              ),
              GetBuilder<SettingsControllerimp>(
                  builder: (controller) => ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: controller.userDataList.length,
                        itemBuilder: (context, index) => CustomSettingsListTile(
                            title: controller.userDataList[index]),
                      )),
              const GreyDivider(),
              Text(
                'الميزات : ',
                style: Theme.of(context).textTheme.headline2,
              ),
              const SizedBox(
                height: 10,
              ),
              GetBuilder<SettingsControllerimp>(
                builder: (controller) => CustomSettingsListTile(
                    title: controller.darkmood == false
                        ? 'الوضع النهاري'
                        : 'الوضع الليلي',
                    trail: Switch(
                      value: controller.darkmood!,
                      onChanged: (val) {
                        controller.changeTheme(val, context);
                      },
                      inactiveTrackColor: AppColors.yellow,
                      inactiveThumbImage: const AssetImage('images/sun.jpg'),
                      activeThumbImage: const AssetImage('images/moon.webp'),
                      activeColor: AppColors.black,
                      activeTrackColor: AppColors.cyan,
                    )),
              ),
              SettingsButton(
                  text: 'إضافة درجات المواد',
                  icon: Icons.menu_book,
                  onPressed: () => Get.to(() => const DergreePage())),
              SettingsButton(
                  text: 'الترفع إلى السنة التالية',
                  icon: Icons.arrow_circle_up_rounded,
                  onPressed: () => controller.nextYearMethod(context)),
              SettingsButton(
                text: 'حول التطبيق',
                icon: Icons.info_outline,
                onPressed: () => Get.toNamed(AppRoutes.aboutAppRoute),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
