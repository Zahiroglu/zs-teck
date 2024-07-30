// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'connections_user_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserConnectionsModelAdapter extends TypeAdapter<UserConnectionsModel> {
  @override
  final int typeId = 3;

  @override
  UserConnectionsModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserConnectionsModel(
      userId: fields[1] as String,
      userFullname: fields[2] as String,
      userRole: fields[3] as int,
      userPhoneNumber: fields[4] as String,
      userEmail: fields[5] as String,
    );
  }

  @override
  void write(BinaryWriter writer, UserConnectionsModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(1)
      ..write(obj.userId)
      ..writeByte(2)
      ..write(obj.userFullname)
      ..writeByte(3)
      ..write(obj.userRole)
      ..writeByte(4)
      ..write(obj.userPhoneNumber)
      ..writeByte(5)
      ..write(obj.userEmail);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserConnectionsModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
