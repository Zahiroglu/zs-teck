import 'package:hive/hive.dart';
import 'dart:convert';
part 'company_model.g.dart';

@HiveType(typeId: 4)
class CompanyModel {
  @HiveField(1)
  String? companyAdress;
  @HiveField(2)
  String? companyId;
  @HiveField(3)
  String? companyMail;
  @HiveField(4)
  String? companyName;
  @HiveField(5)
  String? companyPhone;
  @HiveField(6)
  String? copmanyBaseUrl;
  @HiveField(7)
  List<ModelRegion>? modelRegion;

  CompanyModel({
    this.companyAdress,
    this.companyId,
    this.companyMail,
    this.companyName,
    this.companyPhone,
    this.copmanyBaseUrl,
    this.modelRegion,
  });

  factory CompanyModel.fromRawJson(String str) => CompanyModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CompanyModel.fromJson(Map<String, dynamic> json) => CompanyModel(
    companyAdress: json["companyAdress"],
    companyId: json["companyId"],
    companyMail: json["companyMail"],
    companyName: json["companyName"],
    companyPhone: json["companyPhone"],
    copmanyBaseUrl: json["copmanyBaseUrl"],
    modelRegion: json["modelRegion"],
  );

  Map<String, dynamic> toJson() => {
    "companyAdress": companyAdress,
    "companyId": companyId,
    "companyMail": companyMail,
    "companyName": companyName,
    "companyPhone": companyPhone,
    "copmanyBaseUrl": copmanyBaseUrl,
    "modelRegion": modelRegion,
  };

  @override
  String toString() {
    return 'CompanyModel{companyName: $companyName, copmanyBaseUrl: $copmanyBaseUrl}';
  }
}

@HiveType(typeId: 5)
class ModelRegion {
  @HiveField(1)
  String? regionAdress;
  @HiveField(2)
  String? regionCode;
  @HiveField(3)
  int? regionId;
  @HiveField(4)
  double? regionLatitude;
  @HiveField(5)
  double? regionLongitude;
  @HiveField(6)
  String? regionName;

  ModelRegion({
    this.regionAdress,
    this.regionCode,
    this.regionId,
    this.regionLatitude,
    this.regionLongitude,
    this.regionName,
  });

  factory ModelRegion.fromRawJson(String str) => ModelRegion.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ModelRegion.fromJson(Map<String, dynamic> json) => ModelRegion(
    regionAdress: json["regionAdress"],
    regionCode: json["regionCode"],
    regionId: json["regionId"],
    regionLatitude: json["regionLatitude"],
    regionLongitude: json["regionLongitude"],
    regionName: json["regionName"],
  );

  Map<String, dynamic> toJson() => {
    "regionAdress": regionAdress,
    "regionCode": regionCode,
    "regionId": regionId,
    "regionLatitude": regionLatitude,
    "regionLongitude": regionLongitude,
    "regionName": regionName,
  };

  @override
  String toString() {
    return 'ModelRegion{regionCode: $regionCode, regionName: $regionName}';
  }
}
