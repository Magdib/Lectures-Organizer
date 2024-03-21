import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unversityapp/controller/settingsPagesController/app_data_controllers/share_data_controller.dart';
import 'package:unversityapp/core/class/enums/share_data_state.dart';
import 'package:unversityapp/view/Widgets/shared/CustomButton.dart';

class ShareDataPage extends StatelessWidget {
  const ShareDataPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: GetBuilder<ShareDataController>(
            builder: (controller) => PopScope(
                canPop:
                    !(controller.shareDataState == ShareDataState.unPacking),
                child: controller.shareDataState == ShareDataState.creatingFile
                    ? Center(
                        child: Text(
                          "جارٍ تحضير البيانات للمشاركة الرجاء الإنتظار...\n(وقت طويل غالباً)",
                          textAlign: TextAlign.center,
                          style: Theme.of(context)
                              .textTheme
                              .bodyText2!
                              .copyWith(fontSize: 18),
                        ),
                      )
                    : controller.shareDataState == ShareDataState.searchingSend
                        ? Center(
                            child: Text(
                              "جارٍ البحث عن جهاز للمشاركة...",
                              textAlign: TextAlign.center,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2!
                                  .copyWith(fontSize: 18),
                            ),
                          )
                        : controller.shareDataState ==
                                ShareDataState.searchingReceive
                            ? Center(
                                child: Text(
                                  "بإنتظار جهاز للمشاركة...",
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText2!
                                      .copyWith(fontSize: 18),
                                ),
                              )
                            : controller.shareDataState ==
                                    ShareDataState.failureSend
                                ? Center(
                                    child: CustomButton(
                                        text: "إعادة المحاولة",
                                        onPressed: () =>
                                            controller.retrySend()))
                                : controller.shareDataState ==
                                        ShareDataState.unPacking
                                    ? Center(
                                        child: Text(
                                          "جارٍ تجهيز البيانات للإستخدام...",
                                          textAlign: TextAlign.center,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText2!
                                              .copyWith(fontSize: 18),
                                        ),
                                      )
                                    : Center(
                                        child: Text(
                                          "جارٍ مشاركة البيانات ${controller.sendedMG} /${controller.totalMG} ميغا بايت ${(controller.sendedMG / controller.totalMG * 100).toStringAsFixed(2)}%",
                                          textAlign: TextAlign.center,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText2!
                                              .copyWith(fontSize: 18),
                                        ),
                                      ))),
      ),
    );
  }
}
