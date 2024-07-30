// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'logged_usermodel.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LoggedUserModelAdapter extends TypeAdapter<LoggedUserModel> {
  @override
  final int typeId = 6;

  @override
  LoggedUserModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return LoggedUserModel(
      userModel: fields[0] as UserModel?,
      companyModel: fields[1] as CompanyModel?,
      isLogged: fields[3] as bool?,
      baseUrl: fields[4] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, LoggedUserModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.userModel)
      ..writeByte(1)
      ..write(obj.companyModel)
      ..writeByte(3)
      ..write(obj.isLogged)
      ..writeByte(4)
      ..write(obj.baseUrl);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LoggedUserModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
