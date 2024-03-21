import 'package:hive/hive.dart';
part 'DegreesAdapter.g.dart';

@HiveType(typeId: 2)
class DegreesModel {
  @HiveField(0)
  final int degree;
  @HiveField(1)
  final String subjectName;
  DegreesModel({required this.degree, required this.subjectName});
}
