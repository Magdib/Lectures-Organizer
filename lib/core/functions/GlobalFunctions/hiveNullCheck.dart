import 'package:hive/hive.dart';

import '../../Constant/HiveData/HiveKeysBoxes.dart';

dynamic hiveNullCheck(String hiveKey, dynamic defaultValue) {
  Box userDataBox = Hive.box(HiveBoxes.userDataBox);
  dynamic value;
  userDataBox.get(hiveKey) == null
      ? value = defaultValue
      : value = userDataBox.get(hiveKey);
  return value;
}
