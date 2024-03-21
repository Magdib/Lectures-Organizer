import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unversityapp/controller/settingsPagesController/app_data_controllers/app_data_controller.dart';
import 'package:unversityapp/core/class/enums/data_back_up_state.dart';
import 'package:unversityapp/view/Widgets/MainPages/Settings/app_data_widgets/app_style_column.dart';
import 'package:unversityapp/view/Widgets/MainPages/Settings/app_data_widgets/app_data_loading.dart';
import 'package:unversityapp/view/Widgets/MainPages/Settings/app_data_widgets/data_backup_body.dart';
import 'package:unversityapp/view/Widgets/shared/CustomAppBar.dart';
import 'package:unversityapp/view/Widgets/shared/material_icon_button.dart';

class AppDataPage extends StatelessWidget {
  const AppDataPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AppDataController>(
      builder: (controller) => PopScope(
        canPop:
            controller.dataBackUpState == DataBackUpState.none ? true : false,
        child: Scaffold(
            appBar: customAppBar("خصائص التطبيق", context,
                enableActions: false, enableLeading: false),
            body: AppDataLoading(
              widget: ListView(
                padding: const EdgeInsets.all(10),
                children: [
                  const AppStyleColumn(),
                  Text(
                    "النظام:",
                    style: Theme.of(context)
                        .textTheme
                        .headline2!
                        .copyWith(fontSize: 22),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const DataBackUpBody(),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    "مشاركة المواد:",
                    style: Theme.of(context)
                        .textTheme
                        .headline2!
                        .copyWith(fontSize: 22),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      MaterialIconButton(
                          onPressed: () => controller.receiveData(),
                          icon: Icons.settings_input_antenna_sharp,
                          text: "إستقبال"),
                      MaterialIconButton(
                          onPressed: () => controller.sendData(),
                          icon: Icons.ios_share_rounded,
                          text: "إرسال"),
                    ],
                  )
                ],
              ),
            )),
      ),
    );
  }
}
