import 'dart:convert';
import 'dart:ffi';

import 'package:android_id/android_id.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
export 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:zs_teck/companents/new_models/company_model.dart';
import 'package:zs_teck/companents/new_models/logged_usermodel.dart';
import 'package:zs_teck/companents/new_models/connections_user_model.dart';
import 'package:zs_teck/companents/new_models/user_permitions_model.dart';
import 'package:zs_teck/helpers/dialog_helper.dart';
import 'package:zs_teck/routs/rout_controller.dart';

import '../../companents/new_models/user_model.dart';
import '../../global_widgets/simple_info_dialog.dart';
import '../../helpers/checking_dvice_type.dart';
import '../local_databases_services/local_db_downloads.dart';
import '../local_databases_services/local_users_services.dart';
import 'firebase_token_andnotifications.dart';

class FirebaseUserApiControllerMobile extends GetxController {
  Dio dio = Dio();
  RxBool isLoading = false.obs;
  int dviceType = 0;
  late CheckDviceType checkDviceType = CheckDviceType();
  LocalUserServices localUserServices = LocalUserServices();
  LocalBaseDownloads localBaseDownloads = LocalBaseDownloads();
  late final RxString dviceId = ''.obs;
  RxBool deviceIdMustvisible = false.obs;
  RxInt countClick = 0.obs;
  final _androidIdPlugin = const AndroidId();
  RxString basVerenXeta = "".obs;
  String languageIndex = "az";
  FirebaseTokenGeneratorController firebaseTokenGeneratorController =
      FirebaseTokenGeneratorController();

  //DrawerMenuController controller = Get.put(DrawerMenuController());
  //FirebaseNotyficationController fireTokenServiz=FirebaseNotyficationController();
  @override
  void onInit() {
    localUserServices.init();
    localBaseDownloads.init();

    initPlatformState();
    // TODO: implement onInit
    super.onInit();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  Future<String> getLanguageIndex() async {
    return await Hive.box("myLanguage").get("langCode") ?? "az";
  }

  Future<void> initPlatformState() async {
    deviceIdMustvisible.value = false;
    changeLoading();
    try {
      // deviceId = await PlatformDeviceId.getDeviceId;
      dviceId.value = (await _androidIdPlugin.getId())!;
    } on PlatformException {
      dviceId.value = 'Failed to get deviceId.';
    }
    if (dviceId.value.isNotEmpty) {
      checkIfUserHaveLisance(dviceId.value);
    } else {
      Get.dialog(ShowInfoDialog(
        messaje: "Xeta bas verdi",
        icon: Icons.error_outline,
        callback: () {
          initPlatformState();
        },
      ));
    }
  }

  void changeLoading() {
    isLoading.toggle();
    print("Isloading :" + isLoading.toString());
    update();
  }

  void clouseApp() {
    // Get.delete<DrawerMenuController>();
    Get.reset(clearRouteBindings: true);
    SystemNavigator.pop();
  }

  Future<bool> checkUsersDownloads(int? roleId) async {
    await localBaseDownloads.init();
    return localBaseDownloads.checkIfUserMustDonwloadsBaseFirstTime(roleId);
  }

  Future<void> checkIfUserHaveLisance(String dviceId) async {
    final connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult != ConnectivityResult.none) {
      await FirebaseFirestore.instance
          .collection('db_lisances')
          .where('lisanceId', isEqualTo: dviceId)
          .get()
          .then((QuerySnapshot querySnapshot) async {
        print("querySnapshot.docs.isEmpty " +
            querySnapshot.docs.first['lisanceId'].toString());
        print("querySnapshot.docs.isEmpty companyId " +
            querySnapshot.docs.first['companyId'].toString());
        print("querySnapshot.docs.isEmpty moduleId " +
            querySnapshot.docs.first['moduleId'].toString());
        if (querySnapshot.docs.isEmpty) {
          changeLoading(); // DialogHelper.hideLoading();
          deviceIdMustvisible.value = true;
          basVerenXeta.value = "lisanceError".tr;
          update();
        } else {
          await firebaseTokenGeneratorController
              .reguestForFirebaseNoty()
              .then((val) async {
            if (val) {
              await firebaseTokenGeneratorController
                  .getFireToken()
                  .then((token) async {
                if (token.isNotEmpty) {
                  await getLoggedUserInfo(
                      querySnapshot.docs.first["lisanceId"],
                      querySnapshot.docs.first["companyId"].toString(),
                      token,
                      querySnapshot.docs.first["moduleId"].toString(),
                      querySnapshot.docs.first["roleId"].toString());
                  update();
                }
              });
            } else {
              basVerenXeta.value = "xetaBasverdi".tr;
              update();
            }
          });
        }
      });
    } else {
      Get.dialog(ShowInfoDialog(
        icon: Icons.network_locked_outlined,
        messaje: "internetError".tr,
        callback: () {
          Get.back();
          changeLoading();
          basVerenXeta.value = "internetError".tr;
        },
      ));
    }
    update();
  }

  Future<void> getLoggedUserInfo(String lisanceId, String compId, String token,
      String moduleId, String roleId) async {
    List<UserPermitionsModel> listPermitions = [];
    List<UserConnectionsModel> listConnections = [];
    CompanyModel modelCompany = CompanyModel();
    final connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult != ConnectivityResult.none) {
      await FirebaseFirestore.instance
          .collection('db_users')
          .where('compId', isEqualTo: compId)
          .where('userPhoneId', isEqualTo: lisanceId)
          .get()
          .then((QuerySnapshot querySnapshot) async {
        if (querySnapshot.docs.isEmpty) {
          changeLoading(); // DialogHelper.hideLoading();
          Get.offNamed(RouteHelper.getScreenUsersSelfRegister(), arguments: [
            lisanceId,
            token,
            compId,
            moduleId,
            roleId,
            dviceId.value
          ]);
        } else {
          if (querySnapshot.docs.first["usingStatus"] == false) {
            basVerenXeta.value = "qeydiyyatSorguXetasi".tr;
            changeLoading();
            update();
          } else {
            var listPermition = querySnapshot.docs.first["permitions"];
            var connections = querySnapshot.docs.first["userConnectionsId"];
            listPermitions = await getMyUserPermitions(listPermition);
            modelCompany = await getCompanyDetails(compId,
                int.parse(querySnapshot.docs.first["userRegionId"].toString()));
            await getMyConnectedUsers(connections, compId).then((va) {
              UserModel model = UserModel(
                  roleName: querySnapshot.docs.first["roleName"],
                  roleId: querySnapshot.docs.first["roleId"],
                  userName: querySnapshot.docs.first["userName"],
                  temKod: querySnapshot.docs.first["temKod"],
                  compId: querySnapshot.docs.first["compId"],
                  moduleId: querySnapshot.docs.first["moduleId"].toString(),
                  moduleName: querySnapshot.docs.first["moduleName"],
                  userbirthDay: querySnapshot.docs.first["userbirthDay"],
                  userEmail: querySnapshot.docs.first["userEmail"],
                  userGender: int.tryParse(
                      querySnapshot.docs.first["userGender"].toString()),
                  userId: querySnapshot.docs.first["userId"],
                  userPhone: querySnapshot.docs.first["userPhone"],
                  userPhoneId: querySnapshot.docs.first["userPhoneId"],
                  userRegionId: int.tryParse(
                      querySnapshot.docs.first["userRegionId"].toString()),
                  userSurname: querySnapshot.docs.first["userSurname"],
                  permitions: listPermitions,
                  userConnectionsId: listConnections,
                  fireToken: token,
                  registerDate: querySnapshot.docs.first["registerDate"],
                  followingStatus: querySnapshot.docs.first["followingStatus"],
                  usingStatus: querySnapshot.docs.first["usingStatus"]);
              LoggedUserModel loggedUserModel = LoggedUserModel(
                  baseUrl: modelCompany.copmanyBaseUrl,
                  isLogged: true,
                  userModel: model,
                  companyModel: modelCompany);
              localUserServices.init();
              localUserServices.addUserToLocalDB(loggedUserModel);
              Get.offAllNamed(RouteHelper.getMobileMainScreen());
              changeLoading(); // DialogHelper.hideLoading();
            });
          }
        }
      });
    } else {
      Get.dialog(ShowInfoDialog(
        icon: Icons.network_locked_outlined,
        messaje: "internetError".tr,
        callback: () {
          Get.back();
          changeLoading();
          basVerenXeta.value = "internetError".tr;
        },
      ));
    }
  }

  Future<CompanyModel> getCompanyDetails(String compId, int regionId) async {
    CompanyModel model = CompanyModel();
    await FirebaseFirestore.instance
        .collection('db_companies')
        .where('companyId', isEqualTo: compId)
        .get()
        .then((QuerySnapshot querySnapshot) async {
      if (querySnapshot.docs.isEmpty) {
        ///bu halda qeydiyyatdan kecme sehfesine gonderilmelidir.
      } else {
        await FirebaseFirestore.instance
            .collection('db_companies')
            .doc(querySnapshot.docs.first["companyId"])
            .collection("regions")
            .get()
            .then((querySnapshot2) {
          List<ModelRegion> regions = [];
          for (var data in querySnapshot2.docs) {
            ModelRegion modela = ModelRegion(
                regionName: data["regionName"],
                regionAdress: data["regionAdress"],
                regionId: int.tryParse(data["regionId"].toString()),
                regionCode: data["regionCode"],
                regionLatitude:
                    double.tryParse(data["regionLatitude"].toString()),
                regionLongitude:
                    double.tryParse(data["regionLongitude"].toString()));
            regions.add(modela);
          }
          model = CompanyModel(
            companyId: querySnapshot.docs.first["companyId"],
            companyAdress: querySnapshot.docs.first["companyAdress"],
            companyMail: querySnapshot.docs.first["companyMail"],
            companyName: querySnapshot.docs.first["companyName"],
            companyPhone: querySnapshot.docs.first["companyPhone"],
            copmanyBaseUrl: querySnapshot.docs.first["copmanyBaseUrl"],
            modelRegion: regions,
          );
        });
      }
    });
    return model;
  }

  Future<List<UserPermitionsModel>> getMyUserPermitions(listPermition) async {
    List<UserPermitionsModel> newList = [];
    if (listPermition != null) {
      await FirebaseFirestore.instance
          .collection('db_rolepermitions')
          .where('perCode', whereIn: listPermition)
          .get()
          .then((QuerySnapshot querySnapshot) async {
        if (querySnapshot.docs.isEmpty) {
          print("Icazeler tapilmadi");
        } else {
          for (var e in querySnapshot.docs) {
            UserPermitionsModel model = UserPermitionsModel(
              iconMenu: e["iconMenu"],
              isMenuItems: e["isMenuItems"],
              lang: e["lang"],
              perCode: e["perCode"],
              perValue: e["perValue"],
              iconSelected: e["iconSelected"],
            );
            print("per :" + model.toString());
            newList.add(model);
          }
        }
      });
      print("perCount :" + newList.length.toString());
    }
    return newList;
  }

  Future<List<UserConnectionsModel>> getMyConnectedUsers(
      connections, String compId) async {
    List<UserConnectionsModel> listConnections = [];
    await FirebaseFirestore.instance
        .collection('db_users')
        .where('compId', isEqualTo: compId)
        .where('userId', whereIn: connections)
        .get()
        .then((QuerySnapshot querySnapshot) async {
      if (querySnapshot.docs.isEmpty) {
        print("Baglantilar tapilmadi tapilmadi");
      } else {
        for (var e in querySnapshot.docs) {
          UserConnectionsModel model = UserConnectionsModel(
              userEmail: e["userEmail"],
              userFullname: e["userName"] + " " + e["userSurname"],
              userId: e["userId"],
              userPhoneNumber: e["userPhone"],
              userRole: e["roleName"]);
          listConnections.add(model);
        }
      }
    });
    return listConnections;
  }
}
