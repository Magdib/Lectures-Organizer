// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'DegreesAdapter.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DegreesAdapter extends TypeAdapter<DegreesModel> {
  @override
  final int typeId = 2;

  @override
  DegreesModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DegreesModel(
      degree: fields[0] as int,
      subjectName: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, DegreesModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.degree)
      ..writeByte(1)
      ..write(obj.subjectName);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DegreesAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
