import 'package:hive/hive.dart';
import 'package:unversityapp/core/functions/GlobalFunctions/hiveNullCheck.dart';
import 'package:unversityapp/core/services/Services.dart';
import 'package:unversityapp/model/HiveAdaptersModels/NormalUseModels/LecturesAdapter.dart';

import '../../Constant/HiveData/HiveKeysBoxes.dart';

void addtorecent(
    int index,
    List<LecturesPageModel> lectures,
    List<LecturesPageModel> recentLectures,
    int lectureIndex,
    bool audioPlay) async {
  bool activeMusic = hiveNullCheck(HiveKeys.activeMusic, false);
  if (audioPlay == false && activeMusic) {
    await audioHandler.play();
  }
  Box userDataBox = Hive.box(HiveBoxes.userDataBox);
  Box<LecturesPageModel> recentBox = Hive.box(HiveBoxes.recentBox);
  LecturesPageModel s = lectures[index];
  s.time = DateTime.now().toString();
  if (recentLectures
      .where((lecture) =>
          lecture.lecturename.contains(lectures[index].lecturename))
      .isEmpty) {
    if (recentLectures.length == 8) {
      recentLectures.removeAt(0);
      recentBox.deleteAt(0);
    }
    userDataBox.put(recentLectures.length, lectureIndex);
    recentLectures.add(lectures[index]);
    recentBox.add(recentLectures[recentLectures.length - 1]);
  }
}
