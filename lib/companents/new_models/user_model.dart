import 'package:hive/hive.dart';
import 'dart:convert';

import 'package:zs_teck/companents/new_models/user_permitions_model.dart';

import 'connections_user_model.dart';

part 'user_model.g.dart';

@HiveType(typeId: 1)
class UserModel {
  @HiveField(1)
  String? compId;
  @HiveField(2)
  int? moduleId;
  @HiveField(3)
  String? moduleName;
  @HiveField(4)
  List<UserPermitionsModel>? permitions;
  @HiveField(5)
  int? roleId;
  @HiveField(6)
  String? roleName;
  @HiveField(7)
  String? temKod;
  @HiveField(8)
  List<UserConnectionsModel>? userConnectionsId;
  @HiveField(9)
  String? userEmail;
  @HiveField(10)
  int? userGender;
  @HiveField(11)
  String? userId;
  @HiveField(12)
  String? userName;
  @HiveField(13)
  String? userPhone;
  @HiveField(14)
  String? userPhoneId;
  @HiveField(15)
  int? userRegionId;
  @HiveField(16)
  String? userSurname;
  @HiveField(17)
  String? userbirthDay;
  @HiveField(18)
  String? fireToken;
  @HiveField(19)
  String? registerDate;
  @HiveField(20)
  bool? usingStatus;
  @HiveField(21)
  String? followingStatus;
  @HiveField(22)
  String? userRegionName;

  UserModel({
    this.compId,
    this.moduleId,
    this.moduleName,
    this.permitions,
    this.roleId,
    this.roleName,
    this.temKod,
    this.userConnectionsId,
    this.userEmail,
    this.userGender,
    this.userId,
    this.userName,
    this.userPhone,
    this.userPhoneId,
    this.userRegionId,
    this.userSurname,
    this.userbirthDay,
    this.fireToken,
    this.registerDate,
    this.usingStatus,
    this.followingStatus,
    this.userRegionName,
  });

  factory UserModel.fromRawJson(String str) => UserModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    compId: json["compId"],
    moduleId: json["moduleId"],
    moduleName: json["moduleName"],
    permitions:json["permitions"].map((x) => x),
    roleId: json["roleId"],
    roleName: json["roleName"],
    temKod: json["temKod"],
    userConnectionsId: json["userConnectionsId"],
    userEmail: json["userEmail"],
    userGender: json["userGender"],
    userId: json["userId"],
    userName: json["userName"],
    userPhone: json["userPhone"],
    userPhoneId: json["userPhoneId"],
    userRegionId: json["userRegionId"],
    userSurname: json["userSurname"],
    userbirthDay: json["userbirthDay"],
    fireToken: json["fireToken"],
    registerDate: json["registerDate"],
    usingStatus: json["usingStatus"],
    followingStatus: json["followingStatus"],
    userRegionName: json["userRegionName"],
  );

  Map<String, dynamic> toJson() => {
    "compId": compId,
    "moduleId": moduleId,
    "moduleName": moduleName,
    "permitions": List<dynamic>.from(permitions!.map((x) => x)),
    "roleId": roleId,
    "roleName": roleName,
    "temKod": temKod,
    "userConnectionsId": List<dynamic>.from(userConnectionsId!.map((x) => x)),
    "userEmail": userEmail,
    "userGender": userGender,
    "userId": userId,
    "userName": userName,
    "userPhone": userPhone,
    "userPhoneId": userPhoneId,
    "userRegionId": userRegionId,
    "userSurname": userSurname,
    "userbirthDay": userbirthDay,
    "fireToken": fireToken,
    "registerDate": registerDate,
    "usingStatus": usingStatus,
    "followingStatus": followingStatus,
    "userRegionName": userRegionName,
  };

  @override
  String toString() {
    return 'UserModel{moduleName: $moduleName, permitions: $permitions, roleName: $roleName, userConnectionsId: $userConnectionsId, userId: $userId, userName: $userName, fireToken: $fireToken}';
  }
}
