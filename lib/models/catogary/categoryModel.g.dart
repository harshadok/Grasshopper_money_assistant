// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'categoryModel.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CatogeryModelAdapter extends TypeAdapter<CatogeryModel> {
  @override
  final int typeId = 1;

  @override
  CatogeryModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CatogeryModel(
      id: fields[0] as String,
      name: fields[1] as String,
      isDeleted: fields[2] as bool,
      type: fields[3] as CatogaryType,
    );
  }

  @override
  void write(BinaryWriter writer, CatogeryModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.isDeleted)
      ..writeByte(3)
      ..write(obj.type);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CatogeryModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class CatogaryTypeAdapter extends TypeAdapter<CatogaryType> {
  @override
  final int typeId = 2;

  @override
  CatogaryType read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 1:
        return CatogaryType.icome;
      case 2:
        return CatogaryType.expence;
      default:
        return CatogaryType.icome;
    }
  }

  @override
  void write(BinaryWriter writer, CatogaryType obj) {
    switch (obj) {
      case CatogaryType.icome:
        writer.writeByte(1);
        break;
      case CatogaryType.expence:
        writer.writeByte(2);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CatogaryTypeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
