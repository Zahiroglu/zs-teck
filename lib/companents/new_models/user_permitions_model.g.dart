// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_permitions_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserPermitionsModelAdapter extends TypeAdapter<UserPermitionsModel> {
  @override
  final int typeId = 2;

  @override
  UserPermitionsModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserPermitionsModel(
      iconMenu: fields[1] as String,
      isMenuItems: fields[2] as bool,
      lang: fields[3] as String,
      perCode: fields[4] as String,
      perValue: fields[5] as String,
      iconSelected: fields[6] as String,
    );
  }

  @override
  void write(BinaryWriter writer, UserPermitionsModel obj) {
    writer
      ..writeByte(6)
      ..writeByte(1)
      ..write(obj.iconMenu)
      ..writeByte(2)
      ..write(obj.isMenuItems)
      ..writeByte(3)
      ..write(obj.lang)
      ..writeByte(4)
      ..write(obj.perCode)
      ..writeByte(5)
      ..write(obj.perValue)
      ..writeByte(6)
      ..write(obj.iconSelected);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserPermitionsModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
