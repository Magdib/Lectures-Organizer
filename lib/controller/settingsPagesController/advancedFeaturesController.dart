import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:unversityapp/core/Constant/HiveData/HiveKeysBoxes.dart';
import 'package:unversityapp/core/Routes/routes.dart';
import 'package:unversityapp/core/functions/Dialogs/CreatePdfDialog.dart';
import 'package:unversityapp/core/functions/GlobalFunctions/hiveNullCheck.dart';
import 'package:unversityapp/model/featurePageModel.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:unversityapp/view/Widgets/shared/CustomTextFormFiled.dart';
import 'package:unversityapp/view/Widgets/shared/DialogButton.dart';

abstract class AdvancedFeaturesController extends GetxController {
  checkFeatures();
  featuresVerification(BuildContext context);
  void createPdf();
  goToMusicPage(int x);
}

class AdvancedFeaturesControllerImp extends AdvancedFeaturesController {
  Box userDataBox = Hive.box(HiveBoxes.userDataBox);
  late int studyTime;
  late List<FeaturePageModel> advancedFeaturesList;
  String verificationCode = "VipLecturesOrganizer0937386785";
  late TextEditingController verificationTextController;
  GlobalKey<FormState> verificationKey = GlobalKey<FormState>();
  late bool isVip;

  @override
  checkFeatures() {
    if (isVip) {
      for (int i = 0; i < advancedFeaturesList.length; i++) {
        advancedFeaturesList[i].isEnabled = true;
      }
    } else {
      for (int i = 0; i < advancedFeaturesList.length; i++) {
        if (studyTime >= advancedFeaturesList[i].requiredTimeNum) {
          advancedFeaturesList[i].isEnabled = true;
        }
      }
    }
    update();
  }

  @override
  featuresVerification(BuildContext context) {
    Get.defaultDialog(
        titlePadding: const EdgeInsets.only(top: 8, bottom: 0),
        contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 13),
        title: "كود التفعيل",
        titleStyle: Get.textTheme.headline1,
        content: Form(
          key: verificationKey,
          child: CustomTextFormFiled(
              hint: "أدخل كود التفعيل هنا...",
              validator: (text) =>
                  text == verificationCode ? null : "كود التفعيل غير صحيح",
              editingController: verificationTextController),
        ),
        cancel: DialogButton(
          text: "إلغاء",
          onPressed: () {
            Get.back();
          },
        ),
        confirm: DialogButton(
          text: "تأكيد",
          onPressed: () {
            FormState formState = verificationKey.currentState!;
            if (formState.validate()) {
              Get.back();
              userDataBox.put(HiveKeys.isVip, true);
              isVip = true;
              for (int i = 0; i < advancedFeaturesList.length; i++) {
                advancedFeaturesList[i].isEnabled = true;
              }
              update();
            }
          },
        ));
  }

  @override
  Future<void> goToMusicPage(int x) async {
    PermissionStatus p = await Permission.storage.status;
    if (p.isDenied) {
      await Permission.storage.request();
      if (x == 0) {
        goToMusicPage(1);
      }
    } else {
      Get.toNamed(AppRoutes.musicPageRoute);
    }
  }

  @override
  void createPdf() async {
    final pdf = pw.Document();
    FilePickerResult? result = await FilePicker.platform.pickFiles(
        allowedExtensions: ['png', "jpg", "jpeg"],
        type: FileType.custom,
        allowMultiple: true);
    if (result != null) {
      for (int i = 0; i < result.files.length; i++) {
        PlatformFile pickedImage = result.files[i];
        final image = pw.MemoryImage(
          File(pickedImage.path!).readAsBytesSync(),
        );
        pdf.addPage(pw.Page(build: (pw.Context context) {
          return pw.Center(
              child: pw.Image(
            image,
          )); // Center
        }));
      }
      createPdfDialog(pdf);
    }
  }

  @override
  void onInit() {
    advancedFeaturesList = [
      FeaturePageModel(
          title: 'الوضع السريع',
          icon: Icons.flash_on_outlined,
          requiredTime: "ساعة",
          requiredTimeNum: 1,
          onPressed: () => Get.toNamed(AppRoutes.fastChooseSubjectRoute)),
      FeaturePageModel(
          title: 'تحويل صور إلى pdf',
          icon: Icons.picture_as_pdf_outlined,
          requiredTime: "ثلاث ساعات",
          requiredTimeNum: 3,
          onPressed: () => createPdf()),
      FeaturePageModel(
          title: "موسيقى",
          icon: Icons.my_library_music_outlined,
          requiredTime: "خمس ساعات",
          requiredTimeNum: 5,
          onPressed: () => goToMusicPage(0)),
      // FeaturePageModel(
      //     title: 'صمم أختبارك',
      //     icon: Icons.list_alt_outlined,
      //     requiredTime: "عشر ساعات",
      //     requiredTimeNum: 10,
      //     onPressed: () => Get.toNamed(AppRoutes.createExamPage)),
    ];
    studyTime = hiveNullCheck(HiveKeys.studyTime, 0).floor();
    isVip = hiveNullCheck(HiveKeys.isVip, false);
    checkFeatures();
    verificationTextController = TextEditingController();
    super.onInit();
  }

  @override
  void onClose() {
    verificationTextController.dispose();
    super.onClose();
  }
}
