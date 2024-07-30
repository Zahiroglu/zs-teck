import 'dart:convert';
import 'package:hive/hive.dart';
import 'company_model.dart';
import 'user_model.dart';
part 'logged_usermodel.g.dart';

@HiveType(typeId: 6)
class LoggedUserModel {
  LoggedUserModel({
    this.userModel,
    this.companyModel,
    this.isLogged,
    this.baseUrl,
  });
  @HiveField(0)
  UserModel? userModel;
  @HiveField(1)
  CompanyModel? companyModel;
  @HiveField(3)
  bool? isLogged;
  @HiveField(4)
  String? baseUrl;


  LoggedUserModel copyWith({
    UserModel? userModel,
    CompanyModel? companyModel,
    String? baseUrl,
  }) =>
      LoggedUserModel(
        userModel: userModel ?? this.userModel,
        companyModel: companyModel ?? this.companyModel,
        baseUrl: baseUrl ?? this.baseUrl,
      );


  String toRawJson() => json.encode(toJson());



  Map<String, dynamic> toJson() => {
    "UserModel": userModel?.toJson(),
    "CompanyModel": companyModel?.toJson(),
    "isLogged": isLogged,
    "baseUrl": baseUrl,
  };

  @override
  String toString() {
    return 'LoggedUserModel{userModel: $userModel, companyModel: $companyModel, isLogged: $isLogged, baseUrl: $baseUrl}';
  }
}