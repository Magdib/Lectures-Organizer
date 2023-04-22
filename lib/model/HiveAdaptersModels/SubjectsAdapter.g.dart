// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'SubjectsAdapter.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SubjectsPageModelAdapter extends TypeAdapter<SubjectsPageModel> {
  @override
  final int typeId = 3;

  @override
  SubjectsPageModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SubjectsPageModel(
      id: fields[1] as String?,
      subjectName: fields[0] as String?,
      numberoflecture: fields[3] as int,
      term: fields[2] as int,
    );
  }

  @override
  void write(BinaryWriter writer, SubjectsPageModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.subjectName)
      ..writeByte(1)
      ..write(obj.id)
      ..writeByte(2)
      ..write(obj.term)
      ..writeByte(3)
      ..write(obj.numberoflecture);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SubjectsPageModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
