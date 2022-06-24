// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transcationDB.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TranscationModelAdapter extends TypeAdapter<TranscationModel> {
  @override
  final int typeId = 3;

  @override
  TranscationModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TranscationModel(
      purpose: fields[0] as String,
      amount: fields[1] as double,
      date: fields[2] as DateTime,
      type: fields[3] as CatogaryType,
      catogaryModel: fields[4] as CatogeryModel,
      id: fields[5] as String,
    );
    //.id = fields[5] as String?;
  }

  @override
  void write(BinaryWriter writer, TranscationModel obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.purpose)
      ..writeByte(1)
      ..write(obj.amount)
      ..writeByte(2)
      ..write(obj.date)
      ..writeByte(3)
      ..write(obj.type)
      ..writeByte(4)
      ..write(obj.catogaryModel)
      ..writeByte(5)
      ..write(obj.id);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TranscationModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
