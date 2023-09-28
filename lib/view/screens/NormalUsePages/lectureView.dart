import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import '../../../controller/NormalUsePagesControllers/LectureViewController.dart';
import '../../../core/Constant/AppColors.dart';
import '../../../core/class/HandleLectureState.dart';
import '../../../core/functions/ExitAndRefresh/exitRefreshBookMark.dart';
import '../../../core/functions/ExitAndRefresh/exitRefreshLecture.dart';
import '../../../core/functions/ExitAndRefresh/exitRefreshRecent.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';

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
                  onPressed: () => controller.handleMenuSelection(5),
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
                          : controller.where == 8
                              ? exit(0)
                              : exitLecture,
              child: HandleLectureState(
                lectureState: controller.lectureState,
                errorText: controller.errorText,
                view1: SfPdfViewer.file(
                  File(controller.lecturepath),
                  initialScrollOffset: Offset(0, controller.offset),
                  canShowScrollStatus: false,
                  onPageChanged: (PdfPageChangedDetails details) =>
                      controller.openLastTime(),
                  enableTextSelection: false,
                  onDocumentLoadFailed: (PdfDocumentLoadFailedDetails d) =>
                      controller.handlePdfError(d),
                  controller: controller.pdfViewerController,
                ),
                view2: PDFView(
                  filePath: controller.lecturepath,
                  nightMode: controller.isDarkMode,
                ),
              )),
        ),
      ),
    );
  }
}
