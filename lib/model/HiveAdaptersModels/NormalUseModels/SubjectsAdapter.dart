import 'package:hive/hive.dart';
part 'SubjectsAdapter.g.dart';

@HiveType(typeId: 3)
class SubjectsPageModel {
  @HiveField(0)
  final String? subjectName;
  @HiveField(1)
  final String? id;
  @HiveField(2)
  final int term;
  @HiveField(3)
  int numberoflecture;
  SubjectsPageModel(
      {required this.id,
      required this.subjectName,
      required this.numberoflecture,
      required this.term});
}
