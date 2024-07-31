// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserModelAdapter extends TypeAdapter<UserModel> {
  @override
  final int typeId = 1;

  @override
  UserModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserModel(
      compId: fields[1] as String?,
      moduleId: fields[2] as int?,
      moduleName: fields[3] as String?,
      permitions: (fields[4] as List?)?.cast<UserPermitionsModel>(),
      roleId: fields[5] as int?,
      roleName: fields[6] as String?,
      temKod: fields[7] as String?,
      userConnectionsId: (fields[8] as List?)?.cast<UserConnectionsModel>(),
      userEmail: fields[9] as String?,
      userGender: fields[10] as int?,
      userId: fields[11] as String?,
      userName: fields[12] as String?,
      userPhone: fields[13] as String?,
      userPhoneId: fields[14] as String?,
      userRegionId: fields[15] as int?,
      userSurname: fields[16] as String?,
      userbirthDay: fields[17] as String?,
      fireToken: fields[18] as String?,
      registerDate: fields[19] as String?,
      usingStatus: fields[20] as bool?,
      followingStatus: fields[21] as String?,
      userRegionName: fields[22] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, UserModel obj) {
    writer
      ..writeByte(22)
      ..writeByte(1)
      ..write(obj.compId)
      ..writeByte(2)
      ..write(obj.moduleId)
      ..writeByte(3)
      ..write(obj.moduleName)
      ..writeByte(4)
      ..write(obj.permitions)
      ..writeByte(5)
      ..write(obj.roleId)
      ..writeByte(6)
      ..write(obj.roleName)
      ..writeByte(7)
      ..write(obj.temKod)
      ..writeByte(8)
      ..write(obj.userConnectionsId)
      ..writeByte(9)
      ..write(obj.userEmail)
      ..writeByte(10)
      ..write(obj.userGender)
      ..writeByte(11)
      ..write(obj.userId)
      ..writeByte(12)
      ..write(obj.userName)
      ..writeByte(13)
      ..write(obj.userPhone)
      ..writeByte(14)
      ..write(obj.userPhoneId)
      ..writeByte(15)
      ..write(obj.userRegionId)
      ..writeByte(16)
      ..write(obj.userSurname)
      ..writeByte(17)
      ..write(obj.userbirthDay)
      ..writeByte(18)
      ..write(obj.fireToken)
      ..writeByte(19)
      ..write(obj.registerDate)
      ..writeByte(20)
      ..write(obj.usingStatus)
      ..writeByte(21)
      ..write(obj.followingStatus)
      ..writeByte(22)
      ..write(obj.userRegionName);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
