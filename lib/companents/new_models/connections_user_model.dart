// To parse this JSON data, do
//
//     final userConnectionsModel = userConnectionsModelFromJson(jsonString);

import 'package:hive/hive.dart';
import 'dart:convert';

//part 'user_connections_model.g.dart';

UserConnectionsModel userConnectionsModelFromJson(String str) => UserConnectionsModel.fromJson(json.decode(str));

String userConnectionsModelToJson(UserConnectionsModel data) => json.encode(data.toJson());

@HiveType(typeId: 2)
class UserConnectionsModel {
  @HiveField(1)
  String userId;
  @HiveField(2)
  String userFullname;
  @HiveField(3)
  int userRole;
  @HiveField(4)
  String userPhoneNumber;
  @HiveField(5)
  String userEmail;

  UserConnectionsModel({
    required this.userId,
    required this.userFullname,
    required this.userRole,
    required this.userPhoneNumber,
    required this.userEmail,
  });

  factory UserConnectionsModel.fromJson(Map<String, dynamic> json) => UserConnectionsModel(
    userId: json["userId"],
    userFullname: json["userFullname"],
    userRole: json["userRole"],
    userPhoneNumber: json["userPhoneNumber"],
    userEmail: json["userEmail"],
  );

  Map<String, dynamic> toJson() => {
    "userId": userId,
    "userFullname": userFullname,
    "userRole": userRole,
    "userPhoneNumber": userPhoneNumber,
    "userEmail": userEmail,
  };

  @override
  String toString() {
    return 'UserConnectionsModel{userId: $userId, userFullname: $userFullname, userRole: $userRole, userPhoneNumber: $userPhoneNumber, userEmail: $userEmail}';
  }
}
