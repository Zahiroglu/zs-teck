// To parse this JSON data, do
//
//     final userPermitionsModel = userPermitionsModelFromJson(jsonString);
import 'package:hive/hive.dart';
import 'dart:convert';
//part 'user_permitions_model.g.dart';

UserPermitionsModel userPermitionsModelFromJson(String str) => UserPermitionsModel.fromJson(json.decode(str));

String userPermitionsModelToJson(UserPermitionsModel data) => json.encode(data.toJson());

@HiveType(typeId: 1)
class UserPermitionsModel {
  @HiveField(1)
  String iconMenu;
  @HiveField(2)
  bool isMenuItems;
  @HiveField(3)
  String lang;
  @HiveField(4)
  String perCode;
  @HiveField(5)
  String perValue;

  UserPermitionsModel({
    required this.iconMenu,
    required this.isMenuItems,
    required this.lang,
    required this.perCode,
    required this.perValue,
  });

  factory UserPermitionsModel.fromJson(Map<String, dynamic> json) => UserPermitionsModel(
    iconMenu: json["iconMenu"],
    isMenuItems: json["isMenuItems"],
    lang: json["lang"],
    perCode: json["perCode"],
    perValue: json["perValue"],
  );

  Map<String, dynamic> toJson() => {
    "iconMenu": iconMenu,
    "isMenuItems": isMenuItems,
    "lang": lang,
    "perCode": perCode,
    "perName": perValue,
  };

  @override
  String toString() {
    return 'UserPermitionsModel{iconMenu: $iconMenu, isMenuItems: $isMenuItems, lang: $lang, perCode: $perCode, perName: $perValue}';
  }
}
