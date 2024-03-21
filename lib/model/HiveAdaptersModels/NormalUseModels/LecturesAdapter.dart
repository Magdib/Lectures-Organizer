import 'package:hive/hive.dart';
part 'LecturesAdapter.g.dart';

@HiveType(typeId: 7)
class LecturesPageModel {
  @HiveField(0)
  String lecturename;
  @HiveField(1)
  final String lecturetype;
  @HiveField(2)
  String oldid;
  @HiveField(3)
  String lecturepath;
  @HiveField(4)
  bool check;
  @HiveField(5)
  String time;
  @HiveField(6)
  bool bookMarked;
  @HiveField(7)
  double offset;
  @HiveField(8)
  int? numberofPages;
  @HiveField(9)
  bool chosen;
  LecturesPageModel(
      {required this.check,
      required this.oldid,
      required this.lecturepath,
      required this.lecturename,
      required this.lecturetype,
      required this.time,
      required this.bookMarked,
      required this.offset,
      required this.numberofPages,
      this.chosen = false});
}
