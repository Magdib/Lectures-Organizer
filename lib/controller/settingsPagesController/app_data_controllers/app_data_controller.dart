import 'dart:developer';

import 'dart:io';
import 'package:device_info/device_info.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:unversityapp/controller/MainPagesControllers/SettingsController.dart';
import 'package:unversityapp/core/Constant/HiveData/HiveKeysBoxes.dart';
import 'package:unversityapp/core/Constant/arguments_names.dart';
import 'package:unversityapp/core/Routes/routes.dart';
import 'package:unversityapp/core/class/app_toasts.dart';
import 'package:unversityapp/core/class/enums/data_back_up_state.dart';
import 'package:unversityapp/core/functions/GlobalFunctions/hiveNullCheck.dart';
import 'package:unversityapp/model/HiveAdaptersModels/NormalUseModels/DegreesAdapter.dart';
import 'package:unversityapp/model/HiveAdaptersModels/NormalUseModels/LecturesAdapter.dart';
import 'package:unversityapp/model/HiveAdaptersModels/NormalUseModels/SubjectsAdapter.dart';
import 'package:path/path.dart';
import 'package:location/location.dart' as locationPackage;

class AppDataController extends GetxController {
  Box userDataBox = Hive.box(HiveBoxes.userDataBox);
  late Box<SubjectsPageModel> subjectBox;
  late Box<LecturesPageModel> lecturesBox;
  late Box<LecturesPageModel> recentBox;
  late Box<String> musicPathBox;
  late Box<DegreesModel> degreesBox;
  late bool automaticTheme;
  DataBackUpState dataBackUpState = DataBackUpState.none;
  late Box<String> lecturesNamesBox;
  late bool anyBackUp;
  changeAutomaticThemeState(bool val) {
    userDataBox.put(HiveKeys.automaticTheme, val);
    automaticTheme = val;
    if (val) {
      SettingsControllerimp settingsController = Get.find();
      if (DateTime.now().hour > 16 || DateTime.now().hour < 7) {
        if (settingsController.darkmood == false) {
          settingsController.changeTheme(true);
        }
      } else {
        if (settingsController.darkmood == true) {
          settingsController.changeTheme(false);
        }
      }
    }
    update();
  }

  openAllBoxes() async {
    if (!Hive.isBoxOpen(HiveBoxes.userDataBox)) {
      userDataBox = await Hive.openBox(HiveBoxes.userDataBox);
    }
    subjectBox = await Hive.openBox<SubjectsPageModel>(HiveBoxes.subjectsBox);
    lecturesBox = await Hive.openBox<LecturesPageModel>(HiveBoxes.lecturesBox);
    recentBox = await Hive.openBox<LecturesPageModel>(HiveBoxes.recentBox);
    musicPathBox = await Hive.openBox<String>(HiveBoxes.musicPathBox);
    degreesBox = await Hive.openBox<DegreesModel>(HiveBoxes.degreesBox);
  }

  closeUnnecessaryBoxes() async {
    await userDataBox.close();
    await Hive.box<SubjectsPageModel>(HiveBoxes.subjectsBox).close();
    await Hive.box<LecturesPageModel>(HiveBoxes.lecturesBox).close();
    await Hive.box<LecturesPageModel>(HiveBoxes.recentBox).close();
    await Hive.box<String>(HiveBoxes.musicPathBox).close();
    await Hive.box<DegreesModel>(HiveBoxes.degreesBox).close();
    userDataBox = await Hive.openBox(HiveBoxes.userDataBox);
  }

  dataBackUp() async {
    dataBackUpState = DataBackUpState.backingUp;
    update();
    await openAllBoxes();
    userDataBox.put(HiveKeys.backUpLecturesNumbers, lecturesBox.length);
    Directory? dataDir = await getExternalStorageDirectory();
    String backUpDirPath = "${dataDir!.path}/BackUp";
    Directory? backUpDir = Directory(backUpDirPath);
    if (await backUpDir.exists() == false) {
      backUpDir.create();
    }
    List<Box> boxesList = [
      userDataBox,
      subjectBox,
      lecturesBox,
      recentBox,
      musicPathBox,
      degreesBox
    ];
    for (int i = 0; i < boxesList.length; i++) {
      File box = File(boxesList[i].path!);
      String boxBaseName = basename(box.path);
      String boxCopyPath = "$backUpDirPath/$boxBaseName".replaceAll("'", "");
      await box.copy(boxCopyPath);
    }
    for (int i = 0; i < lecturesBox.length; i++) {
      File lecture = File(lecturesBox.getAt(i)!.lecturepath);
      String lectureBaseName = basename(lecture.path);
      String lectureCopyPath = "$backUpDirPath/$lectureBaseName";
      await lecture.copy(lectureCopyPath);
      await lecturesNamesBox.put(i, lectureCopyPath);
    }
    await closeUnnecessaryBoxes();
    await userDataBox.put(HiveKeys.anyBackUp, true);
    dataBackUpState = DataBackUpState.none;
    AppToasts.successToast("تم نسخ البيانات بنجاح");
    Get.offNamedUntil(AppRoutes.mainPageRoute, (route) => false);
    update();
  }

  getBackUp() async {
    Directory? dataDir = await getExternalStorageDirectory();
    String backUpDirPath = "${dataDir!.path}/BackUp";
    Directory? backUpDir = Directory(backUpDirPath);
    if (await backUpDir.exists() == false) {
      AppToasts.showErrorToast("لا بوجد بيانات محفوطة");
    } else {
      dataBackUpState = DataBackUpState.gettingData;
      update();
      await openAllBoxes();
      List<Box> boxesList = [
        userDataBox,
        subjectBox,
        lecturesBox,
        recentBox,
        musicPathBox,
        degreesBox
      ];
      for (int i = 0; i < boxesList.length; i++) {
        File box = File(boxesList[i].path!);
        String boxBaseName = basename(box.path);
        String boxCopyPath = "$backUpDirPath/$boxBaseName".replaceAll("'", "");
        File dataBox = File(boxCopyPath);
        dataBox.copySync(box.path);
      }
      log("Copy Box Done...");
      for (int i = 0;
          i < userDataBox.get(HiveKeys.backUpLecturesNumbers);
          i++) {
        File lecture = File(lecturesNamesBox.getAt(i)!);
        String lectureBaseName = basename(lecture.path);
        String lectureCopyPath = "${dataDir.path}/$lectureBaseName";
        lecture.copy(lectureCopyPath);
      }
      await closeUnnecessaryBoxes();
      dataBackUpState = DataBackUpState.none;
      AppToasts.successToast("تمت إستعادة البيانات بنجاح");
      Get.offNamedUntil(AppRoutes.mainPageRoute, (route) => false);
      update();
    }
  }

  Future<bool> checkSharePermissions() async {
    if (!await Permission.location.isGranted) {
      PermissionStatus permissionStatus = await Permission.location.request();
      if (!permissionStatus.isGranted) {
        AppToasts.showErrorToast("تم رفض الوصول للموقع!");
        return false;
      }
    }
    if (!await Permission.storage.isGranted) {
      PermissionStatus permissionStatus = await Permission.storage.request();
      if (!permissionStatus.isGranted) {
        AppToasts.showErrorToast("تم رفض الوصول للذاكرة!");
        return false;
      }
    }
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    double androidVersion = 0;

    try {
      androidVersion = double.parse(androidInfo.version.release);
    } catch (e) {
      AppToasts.showErrorToast("الخدمة غير مدعومة في نظامك");
      return false;
    }
    if (androidVersion > 13) {
      if (!await Permission.nearbyWifiDevices.isGranted) {
        PermissionStatus permissionStatus =
            await Permission.nearbyWifiDevices.request();
        if (!permissionStatus.isGranted) {
          AppToasts.showErrorToast("تم رفض الوصول للأجهزة القريبة!");
          return false;
        }
      }
    }
    locationPackage.Location location = locationPackage.Location();
    bool serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return false;
      }
    }
    return true;
  }

  void sendData() async {
    if (userDataBox.get(HiveKeys.lecturesNumber) != 0 &&
        userDataBox.get(HiveKeys.lecturesNumber) != null) {
      if (await checkSharePermissions()) {
        Get.toNamed(AppRoutes.shareDataPage,
            arguments: {ArgumentsNames.isReceiver: false});
      }
    } else {
      AppToasts.showErrorToast("لا يوجد محاضرات لمشاركتها!");
    }
  }

  void receiveData() async {
    if (await checkSharePermissions()) {
      Get.toNamed(AppRoutes.shareDataPage,
          arguments: {ArgumentsNames.isReceiver: true});
    }
  }

  @override
  void onReady() async {
    lecturesNamesBox = await Hive.openBox(HiveBoxes.lecturesNamesBox);
    super.onReady();
  }

  @override
  void onInit() {
    automaticTheme = hiveNullCheck(HiveKeys.automaticTheme, false);
    anyBackUp = hiveNullCheck(HiveKeys.anyBackUp, false);
    super.onInit();
  }
}
