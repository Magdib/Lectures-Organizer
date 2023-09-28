import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unversityapp/controller/NormalUsePagesControllers/LectureViewController.dart';
import 'package:unversityapp/view/Widgets/NormalUsePages/LectureView/ViewAppBar.dart';

import '../Constant/AppColors.dart';
import 'enums/LectureState.dart';

class HandleLectureState extends StatelessWidget {
  const HandleLectureState(
      {Key? key,
      required this.lectureState,
      required this.view1,
      required this.view2,
      required this.errorText})
      : super(key: key);
  final LectureState lectureState;
  final Widget view1;
  final Widget view2;
  final String errorText;
  @override
  Widget build(BuildContext context) {
    return lectureState == LectureState.loadingFailed
        ? Container(
            padding: const EdgeInsets.all(10.0),
            color: AppColors.veryDeepred,
            child: Center(
              child: Text(
                "فشل فتح الملف الرجاء إعادة تشغيل التطبيق.\n\n في حالة أستمرار الفشل قد يكون الملف معطوب أو تم تغيير مكانه من المسار:\n storage/emulated/0/Android/data/com.magdibrahem.unversityapp/files \nويجب إعادة إضافته مجدداً.\n\n$errorText ",
                style: Theme.of(context)
                    .textTheme
                    .headline3!
                    .copyWith(fontSize: 18),
              ),
            ),
          )
        : Stack(
            children: [
              GetBuilder<LectureViewControllerImp>(
                builder: (controller) => Padding(
                  padding: EdgeInsets.only(top: controller.appBarHeight),
                  child: lectureState == LectureState.view1 ? view1 : view2,
                ),
              ),
              const ViewAppBar()
            ],
          );
  }
}
