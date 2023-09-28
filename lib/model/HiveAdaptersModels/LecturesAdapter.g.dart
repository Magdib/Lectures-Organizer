// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'LecturesAdapter.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LecturesPageModelAdapter extends TypeAdapter<LecturesPageModel> {
  @override
  final int typeId = 7;

  @override
  LecturesPageModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return LecturesPageModel(
      check: fields[4] as bool,
      oldid: fields[2] as String,
      lecturepath: fields[3] as String,
      lecturename: fields[0] as String,
      lecturetype: fields[1] as String,
      time: fields[5] as String,
      bookMarked: fields[6] as bool,
      offset: fields[7] as double,
      numberofPages: fields[8] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, LecturesPageModel obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.lecturename)
      ..writeByte(1)
      ..write(obj.lecturetype)
      ..writeByte(2)
      ..write(obj.oldid)
      ..writeByte(3)
      ..write(obj.lecturepath)
      ..writeByte(4)
      ..write(obj.check)
      ..writeByte(5)
      ..write(obj.time)
      ..writeByte(6)
      ..write(obj.bookMarked)
      ..writeByte(7)
      ..write(obj.offset)
      ..writeByte(8)
      ..write(obj.numberofPages);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LecturesPageModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
