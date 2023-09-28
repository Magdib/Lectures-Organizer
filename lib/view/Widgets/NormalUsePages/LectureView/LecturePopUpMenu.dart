import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unversityapp/core/class/enums/LectureState.dart';

import '../../../../controller/NormalUsePagesControllers/LectureViewController.dart';
import '../../../../core/Constant/AppColors.dart';
import 'LecturePopUpChild.dart';

class LecturePopUpMenu extends GetView<LectureViewControllerImp> {
  const LecturePopUpMenu({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      itemBuilder: (context) => [
        const PopupMenuItem(
            value: 0,
            child: LecturePopUpChild(
              text: 'مشاركة',
              icon: Icons.share_outlined,
            )),
        const PopupMenuItem(
            value: 1,
            child: LecturePopUpChild(
              text: 'تحميل',
              icon: Icons.file_download_outlined,
            )),
        PopupMenuItem(
            value: 2,
            child: LecturePopUpChild(
              text: controller.lectureData.bookMarked == false
                  ? 'حفظ'
                  : 'إلغاء الحفظ',
              icon: controller.lectureData.bookMarked == false
                  ? Icons.bookmark_add_outlined
                  : Icons.bookmark_remove_outlined,
            )),
        PopupMenuItem(
            value: 3,
            child: LecturePopUpChild(
              text: controller.lectureData.check == false
                  ? 'تمت دراستها'
                  : "لم تتم دراستها",
              icon: controller.lectureData.check == false
                  ? Icons.check_circle_outlined
                  : Icons.remove_done_outlined,
            )),
        if (controller.selectedViewer == 0)
          const PopupMenuItem(
              value: 4,
              child: LecturePopUpChild(
                text: 'بحث',
                icon: Icons.search_rounded,
              )),
        const PopupMenuItem(
            value: 5,
            child: LecturePopUpChild(
              text: 'إخفاء الشريط',
              icon: Icons.disabled_by_default_outlined,
            )),
      ],
      enableFeedback: false,
      icon: const Icon(
        Icons.more_vert,
        color: AppColors.white,
      ),
      onSelected: (val) => controller.handleMenuSelection(val as int),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      position: PopupMenuPosition.under,
      color: Theme.of(context).scaffoldBackgroundColor,
    );
  }
}
