import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:unversityapp/core/Constant/HiveData/HiveKeysBoxes.dart';
import 'package:unversityapp/core/class/enums/DataState.dart';
import 'package:unversityapp/core/functions/GlobalFunctions/hiveNullCheck.dart';
import 'package:just_audio/just_audio.dart';

abstract class MusicController extends GetxController {
  Future<void> getSongs();
  void changeMusicState(bool val);
  void addRemoveSongs(int index);
  Future<bool> onwillpopInfo();
  Future<void> testMusic(int index);
}

class MusicControllerimp extends MusicController {
  Box userDataBox = Hive.box(HiveBoxes.userDataBox);
  late Box<String> musicPathBox;
  final OnAudioQuery _audioQuery = OnAudioQuery();
  late AudioPlayer audioPlayer;
  List<SongModel> songs = [];
  late bool activeMusic;
  List<bool> activeSongs = [];
  List<String> musicPaths = [];
  DataState dataState = DataState.loading;
  bool musicPlaying = false;
  @override
  void changeMusicState(bool val) {
    activeMusic = val;
    userDataBox.put(HiveKeys.activeMusic, val);
    update();
  }

  @override
  Future<void> getSongs() async {
    musicPathBox = await Hive.openBox(HiveBoxes.musicPathBox);
    songs = await _audioQuery.querySongs();
    songs.removeWhere((song) => song.isNotification!);
    songs.isNotEmpty
        ? dataState = DataState.notEmpty
        : dataState = DataState.empty;
    musicPaths = musicPathBox.values.toList();
    for (int i = 0; i < songs.length; i++) {
      if (musicPaths.isNotEmpty) {
        if (musicPaths.indexWhere((path) => path == songs[i].data) != -1) {
          activeSongs.add(true);
        } else {
          activeSongs.add(false);
        }
      } else {
        activeSongs.add(false);
      }
    }
    await Future.delayed(const Duration(milliseconds: 1500));

    update();
  }

  @override
  void addRemoveSongs(int index) {
    if (activeSongs[index] == true) {
      int musicPathIndex =
          musicPaths.indexWhere((path) => path == songs[index].data);
      musicPathBox.deleteAt(musicPathIndex);
      musicPaths.removeAt(musicPathIndex);
    } else {
      musicPaths.add(songs[index].data);
      musicPathBox.add(songs[index].data);
    }
    activeSongs[index] = !activeSongs[index];
    update();
  }

  @override
  Future<void> testMusic(int index) async {
    musicPlaying = !musicPlaying;
    update();
    if (musicPlaying) {
      await audioPlayer.setFilePath(songs[index].data);
      await audioPlayer.play();
    } else {
      audioPlayer.stop();
    }
  }

  @override
  Future<bool> onwillpopInfo() async {
    if (musicPlaying) {
      await audioPlayer.stop();
    }
    musicPlaying = false;
    Get.back();
    return Future.value(false);
  }

  @override
  void onReady() async {
    await getSongs();
    super.onReady();
  }

  @override
  void onInit() {
    audioPlayer = AudioPlayer();
    activeMusic = hiveNullCheck(HiveKeys.activeMusic, false);
    super.onInit();
  }

  @override
  void onClose() {
    audioPlayer.dispose();
    super.onClose();
  }
}
