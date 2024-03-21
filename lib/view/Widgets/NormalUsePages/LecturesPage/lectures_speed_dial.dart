import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:get/get.dart';
import 'package:unversityapp/controller/NormalUsePagesControllers/LecturePageController.dart';
import 'package:unversityapp/core/Constant/AppColors.dart';
import 'package:unversityapp/core/class/enums/lectures_dial_state.dart';
import 'package:unversityapp/core/functions/Dialogs/LecturesDialogs.dart';

class LecturesSpeedDial extends StatelessWidget {
  const LecturesSpeedDial({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LecturePageControllerimp>(
      builder: (controller) => SpeedDial(
        openCloseDial: controller.isDialOpen,
        spaceBetweenChildren: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        childrenButtonSize: const Size(52.5, 60),
        overlayOpacity: 0.4,
        overlayColor: AppColors.black,
        animatedIconTheme: const IconThemeData(
          color: AppColors.white,
        ),
        animatedIcon: AnimatedIcons.menu_close,
        children: controller.isChoosing
            ? [
                SpeedDialChild(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  backgroundColor: AppColors.veryDeepRed,
                  onTap: () => controller.changeDialState(),
                  child: const Icon(
                    Icons.close,
                    color: AppColors.white,
                    size: 27.5,
                  ),
                ),
                SpeedDialChild(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  backgroundColor: AppColors.weightBlue,
                  onTap: () =>
                      controller.handleChoosingDial(LecturesDialState.editing),
                  child: const Icon(
                    Icons.edit_outlined,
                    color: AppColors.white,
                    size: 27.5,
                  ),
                ),
                SpeedDialChild(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  backgroundColor: AppColors.deepGreen,
                  onTap: () =>
                      controller.handleChoosingDial(LecturesDialState.sharing),
                  child: const Icon(
                    Icons.share_outlined,
                    color: AppColors.white,
                  ),
                ),
                SpeedDialChild(
                  onTap: () =>
                      controller.handleChoosingDial(LecturesDialState.deleting),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  backgroundColor: AppColors.moreDeepred,
                  child: const Icon(
                    Icons.delete_outline_rounded,
                    size: 27.5,
                    color: AppColors.white,
                  ),
                ),
              ]
            : [
                SpeedDialChild(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  backgroundColor: AppColors.weightBlue,
                  onTap: () => lectureaddDialog(
                    context,
                  ),
                  child: const Icon(
                    Icons.add,
                    color: AppColors.white,
                    size: 27.5,
                  ),
                ),
                SpeedDialChild(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  backgroundColor: AppColors.deepGreen,
                  onTap: () => controller.countTotalPages(context),
                  child: const Icon(
                    Icons.onetwothree_outlined,
                    color: AppColors.white,
                    size: 40,
                  ),
                ),
                SpeedDialChild(
                  onTap: () => controller.changeDialState(),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  backgroundColor: AppColors.moreDeepred,
                  child: const Icon(
                    Icons.list_alt_rounded,
                    color: AppColors.white,
                  ),
                ),
              ],
      ),
    );
  }
}
