import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';

import '../../model/HiveAdaptersModels/DegreesAdapter.dart';
import '../../model/HiveAdaptersModels/LecturesAdapter.dart';
import '../../model/HiveAdaptersModels/SubjectsAdapter.dart';
import '../Constant/HiveData/HiveKeysBoxes.dart';

class Services extends GetxService {
  Box? userDataBox;
  Future<Services> init() async {
    await Hive.initFlutter();
    userDataBox = await Hive.openBox(HiveBoxes.userDataBox);
    Hive.registerAdapter<DegreesModel>(DegreesAdapter());
    Hive.registerAdapter<SubjectsPageModel>(SubjectsPageModelAdapter());
    Hive.registerAdapter<LecturesPageModel>(LecturesPageModelAdapter());
    return this;
  }
}

initialServices() async {
  await Get.putAsync(() => Services().init());
}
