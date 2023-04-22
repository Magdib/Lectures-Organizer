import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import '../../../controller/NormalUsePagesControllers/LectureViewController.dart';
import '../../../core/Constant/AppColors.dart';
import '../../../core/Constant/uiNumber.dart';
import '../../../core/class/HandleLectureState.dart';
import '../../../core/functions/ExitAndRefresh/exitRefreshBookMark.dart';
import '../../../core/functions/ExitAndRefresh/exitRefreshLecture.dart';
import '../../../core/functions/ExitAndRefresh/exitRefreshRecent.dart';
import '../../Widgets/NormalUsePages/LectureView/LecturePopUpMenu.dart';

class LectureView extends StatelessWidget {
  const LectureView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(LectureViewControllerImp());
    return SafeArea(
      child: GetBuilder<LectureViewControllerImp>(
        builder: (controller) => Scaffold(
          floatingActionButton: controller.appBarHeight != 0
              ? null
              : FloatingActionButton(
                  onPressed: () => controller.handleMenuSelection(4, context),
                  backgroundColor: Theme.of(context)
                      .floatingActionButtonTheme
                      .backgroundColor,
                  mini: true,
                  child: const Icon(
                    Icons.remove_red_eye_outlined,
                    color: AppColors.white,
                  )),
          body: WillPopScope(
              onWillPop: controller.where == 0
                  ? exitRefreshLecture
                  : controller.where == 1
                      ? exitRefreshBookMark
                      : controller.where == 2
                          ? exitRefreshRecent
                          : exitLecture,
              child: HandleLectureState(
                lectureState: controller.lectureState,
                errorText: controller.errorText,
                view1: Stack(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: controller.appBarHeight),
                      child: SfPdfViewer.file(
                        File(controller.lecturepath),
                        initialScrollOffset: Offset(0, controller.offset),
                        canShowScrollStatus: false,
                        onPageChanged: (PdfPageChangedDetails details) =>
                            controller.openLastTime(),
                        enableTextSelection: true,
                        onDocumentLoadFailed:
                            (PdfDocumentLoadFailedDetails d) =>
                                controller.handlePdfError(d),
                        onTextSelectionChanged:
                            (PdfTextSelectionChangedDetails details) =>
                                controller.onTextSelectionChanged(
                                    details, context),
                        controller: controller.pdfViewerController,
                      ),
                    ),
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 500),
                      height: controller.appBarHeight,
                      color: Theme.of(context)
                          .floatingActionButtonTheme
                          .backgroundColor,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                              onPressed: () => controller.where == 0
                                  ? exitRefreshLecture()
                                  : controller.where == 1
                                      ? exitRefreshBookMark()
                                      : controller.where == 2
                                          ? exitRefreshRecent()
                                          : exitLecture(),
                              icon: const Icon(
                                Icons.arrow_back,
                                color: AppColors.white,
                              )),
                          SizedBox(
                            width: UINumbers.deviceWidth - 120,
                            child: Text(
                              controller.lecturename.replaceAll('.pdf', ''),
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(fontSize: 15),
                            ),
                          ),
                          const LecturePopUpMenu()
                        ],
                      ),
                    ),
                  ],
                ),
                view2: const SizedBox(),
              )),
        ),
      ),
    );
  }
}
