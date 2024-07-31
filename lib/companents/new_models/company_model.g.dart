// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'company_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CompanyModelAdapter extends TypeAdapter<CompanyModel> {
  @override
  final int typeId = 4;

  @override
  CompanyModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CompanyModel(
      companyAdress: fields[1] as String?,
      companyId: fields[2] as String?,
      companyMail: fields[3] as String?,
      companyName: fields[4] as String?,
      companyPhone: fields[5] as String?,
      copmanyBaseUrl: fields[6] as String?,
      modelRegion: (fields[7] as List?)?.cast<ModelRegion>(),
    );
  }

  @override
  void write(BinaryWriter writer, CompanyModel obj) {
    writer
      ..writeByte(7)
      ..writeByte(1)
      ..write(obj.companyAdress)
      ..writeByte(2)
      ..write(obj.companyId)
      ..writeByte(3)
      ..write(obj.companyMail)
      ..writeByte(4)
      ..write(obj.companyName)
      ..writeByte(5)
      ..write(obj.companyPhone)
      ..writeByte(6)
      ..write(obj.copmanyBaseUrl)
      ..writeByte(7)
      ..write(obj.modelRegion);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CompanyModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class ModelRegionAdapter extends TypeAdapter<ModelRegion> {
  @override
  final int typeId = 5;

  @override
  ModelRegion read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ModelRegion(
      regionAdress: fields[1] as String?,
      regionCode: fields[2] as String?,
      regionId: fields[3] as int?,
      regionLatitude: fields[4] as double?,
      regionLongitude: fields[5] as double?,
      regionName: fields[6] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, ModelRegion obj) {
    writer
      ..writeByte(6)
      ..writeByte(1)
      ..write(obj.regionAdress)
      ..writeByte(2)
      ..write(obj.regionCode)
      ..writeByte(3)
      ..write(obj.regionId)
      ..writeByte(4)
      ..write(obj.regionLatitude)
      ..writeByte(5)
      ..write(obj.regionLongitude)
      ..writeByte(6)
      ..write(obj.regionName);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ModelRegionAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
