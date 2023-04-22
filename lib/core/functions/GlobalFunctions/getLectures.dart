import 'package:hive/hive.dart';

import '../../../model/HiveAdaptersModels/LecturesAdapter.dart';
import '../../Constant/HiveData/HiveKeysBoxes.dart';

void getLectures(Box<dynamic> userDataBox, Box<LecturesPageModel> lecturesBox,
    List<LecturesPageModel> lectures) {
  if (userDataBox.get(HiveKeys.lecturesNumber) != null) {
    for (int i = 0; i < lecturesBox.length; i++) {
      if (lecturesBox.getAt(i) != null) {
        lectures.add(lecturesBox.getAt(i)!);
      }
    }
  }
}
