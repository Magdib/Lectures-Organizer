import 'package:path_provider/path_provider.dart';

Future<String> getMyLecturesSaveFolder() async {
  String saveFolder = "";
  await getDownloadsDirectory()
      .then((directory) => saveFolder = "${directory!.path}/محاضراتي/");
  return saveFolder;
}

Future<String> getSavedLecturesSaveFolder() async {
  String saveFolder = "";
  await getDownloadsDirectory().then(
      (directory) => saveFolder = "${directory!.path}/المحاضرات المحفوظة/");
  return saveFolder;
}
