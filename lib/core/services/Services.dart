import 'dart:async';

import 'package:audio_service/audio_service.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';
import '../../model/HiveAdaptersModels/DegreesAdapter.dart';
import '../../model/HiveAdaptersModels/LecturesAdapter.dart';
import '../../model/HiveAdaptersModels/SubjectsAdapter.dart';
import '../Constant/HiveData/HiveKeysBoxes.dart';
import 'MyAudioHandler.dart';

late AudioHandler audioHandler;

class Services extends GetxService {
  Box? userDataBox;
  Future<Services> init() async {
    await Hive.initFlutter();
    Hive.registerAdapter<DegreesModel>(DegreesModelAdapter());
    Hive.registerAdapter<SubjectsPageModel>(SubjectsPageModelAdapter());
    Hive.registerAdapter<LecturesPageModel>(LecturesPageModelAdapter());
    userDataBox = await Hive.openBox(HiveBoxes.userDataBox);
    await Hive.openBox<String>(HiveBoxes.musicPathBox);
    audioHandler = await AudioService.init(
      builder: () => MyAudioHandler(),
      config: const AudioServiceConfig(
        androidNotificationChannelId:
            'com.magdibrahem.unversityapp.channel.audio',
        androidNotificationChannelName: 'Audio playback',
        androidNotificationOngoing: true,
      ),
    );

    return this;
  }
}

initialServices() async {
  await Get.putAsync(() => Services().init());
}
