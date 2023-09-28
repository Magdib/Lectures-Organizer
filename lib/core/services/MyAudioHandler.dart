import 'package:audio_service/audio_service.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:just_audio/just_audio.dart';
import 'package:unversityapp/core/Constant/HiveData/HiveKeysBoxes.dart';

import 'package:path/path.dart';

class MyAudioHandler extends BaseAudioHandler
    with
        QueueHandler, // mix in default queue callback implementations
        SeekHandler {
  final _player = AudioPlayer();
  Box<String> musicBox = Hive.box(HiveBoxes.musicPathBox);
  List<String> songsPaths = [];
  int song = 0;
  Duration? playposition;
  @override
  Future<void> play() async {
    playbackState.add(playbackState.value.copyWith(controls: [
      MediaControl.skipToPrevious,
      MediaControl.pause,
      MediaControl.stop,
      MediaControl.skipToNext,
    ], playing: true));

    if (musicBox.isNotEmpty) {
      songsPaths = musicBox.values.toList();

      mediaItem.add(MediaItem(
          id: "$song",
          title: basename(songsPaths[song]),
          artUri: Uri.file(songsPaths[song])));
      await _player.setFilePath(songsPaths[song]);
      if (playposition != null) {
        await _player.seek(playposition);
      }
      playposition = null;
      await _player.play();

      _player.playerStateStream.listen((playerState) {
        if (playerState.processingState == ProcessingState.completed) {
          skipToNext();
        }
      });
    }
  }

  @override
  Future<void> pause() async {
    playposition = _player.position;
    await _player.pause();
    playbackState.add(playbackState.value.copyWith(controls: [
      MediaControl.skipToPrevious,
      MediaControl.play,
      MediaControl.stop,
      MediaControl.skipToNext,
    ], playing: false));
  }

  @override
  Future<void> stop() async {
    await _player.stop();
    playbackState
        .add(playbackState.value.copyWith(controls: [], playing: false));
    playposition = null;
  }

  @override
  Future<void> skipToNext() async {
    if (song != songsPaths.length - 1) {
      song++;
    } else {
      song = 0;
    }
    await play();
  }

  @override
  Future<void> skipToPrevious() async {
    if (song > 0) {
      song--;
    } else {
      song = songsPaths.length - 1;
    }
    await play();
  }

  @override
  Future<void> seek(Duration position) async {
    await _player.seek(position);
  }

  @override
  MyAudioHandler() {
    playbackState.add(PlaybackState(
      systemActions: const {
        MediaAction.pause,
        MediaAction.stop,
        MediaAction.skipToNext,
        MediaAction.skipToPrevious,
        MediaAction.play
      },
      androidCompactActionIndices: const [0, 1, 3],
      processingState: AudioProcessingState.ready,
      playing: false,
      updatePosition: const Duration(milliseconds: 500),
      bufferedPosition: const Duration(milliseconds: 500),
      speed: 1.0,
      queueIndex: 0,
    ));
  }
}
