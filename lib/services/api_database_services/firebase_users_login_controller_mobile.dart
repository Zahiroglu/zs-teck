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
import 'package:zs_teck/companents/login/models/user_model.dart';
import 'package:zs_teck/companents/new_models/connections_user_model.dart';
import 'package:zs_teck/companents/new_models/user_permitions_model.dart';
import 'package:zs_teck/helpers/dialog_helper.dart';

import '../../global_widgets/simple_info_dialog.dart';
import '../../helpers/checking_dvice_type.dart';
import '../local_databases_services/local_db_downloads.dart';
import '../local_databases_services/local_users_services.dart';

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
  String basVerenXeta = "";
  String languageIndex = "az";
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
    changeLoading();
  }

  void changeLoading() {
    isLoading.toggle();
    print("Isloading :" + isLoading.toString());
    update();
  }

  void clouseApp() {
   // Get.delete<DrawerMenuController>();
    Get.reset(clearRouteBindings: true); SystemNavigator.pop();
  }



  Future<bool> checkUsersDownloads(int? roleId) async{
    await localBaseDownloads.init();
    return  localBaseDownloads.checkIfUserMustDonwloadsBaseFirstTime(roleId);
  }

  void checkIfUserHaveLisance(String dviceId) {
    DialogHelper.showLoading("yoxlanir".tr);
    FirebaseFirestore.instance.collection('db_lisances').where('lisanceId', isEqualTo: dviceId).get()
        .then((QuerySnapshot querySnapshot) {
          if( querySnapshot.docs.isEmpty){
            deviceIdMustvisible.value=true;
            print("device id : "+dviceId);

            basVerenXeta="lisanceError".tr;
          }else{
            print("device id : "+querySnapshot.docs.first["lisanceId"]);
            print("companyId : "+querySnapshot.docs.first["companyId"].toString());
            getLoggedUserInfo(querySnapshot.docs.first["lisanceId"]);
          }
    });
    DialogHelper.hideLoading();
    update();
  }

  void getLoggedUserInfo(String lisanceId) {
    List<UserPermitionsModel> listPermitions=[];
    List<UserConnectionsModel> listConnections=[];
    FirebaseFirestore.instance.collection('db_users').where('userPhoneId', isEqualTo: lisanceId).get()
        .then((QuerySnapshot querySnapshot) async {
      if( querySnapshot.docs.isEmpty){
        ///bu halda qeydiyyatdan kecme sehfesine gonderilmelidir.

      }else{
        var listPermition=querySnapshot.docs.first["permitions"];
        var connections=querySnapshot.docs.first["userConnectionsId"];
        listPermitions=await getMyUserPermitions(listPermition);
        listConnections=await getMyConnectedUsers(connections);
        print("list permitions: "+listPermition.toString());
        print("list connections: "+listConnections.toString());
      }
    });
  }

 Future<List<UserPermitionsModel>> getMyUserPermitions(listPermition)async {
   List<UserPermitionsModel> listPermitions=[];
   FirebaseFirestore.instance.collection('db_rolepermitions').where('perCode', whereIn: listPermition).get()
       .then((QuerySnapshot querySnapshot) async {
     if( querySnapshot.docs.isEmpty){
       print("Icazeler tapilmadi");
     }else{
       querySnapshot.docs.forEach((e){
         print("e permitions : "+e.toString());//permitions list
        UserPermitionsModel model=UserPermitionsModel(
          iconMenu: e["iconMenu"],
          isMenuItems: e["isMenuItems"],
          lang: e["lang"],
          perCode: e["perCode"],
            perValue: e["perValue"]
        );
        print("model permitions :"+model.toString());
        listPermitions.add(model);
       });
     }
   });
   return listPermitions;
 }

  Future<List<UserConnectionsModel>>  getMyConnectedUsers(connections) async{
    List<UserConnectionsModel> listConnections=[];
    FirebaseFirestore.instance.collection('db_users').where('userId', whereIn: connections).get()
        .then((QuerySnapshot querySnapshot) async {
      if( querySnapshot.docs.isEmpty){
        print("Baglantilar tapilmadi tapilmadi");
      }else{
        for (var e in querySnapshot.docs) {
          UserConnectionsModel model=UserConnectionsModel(
              userEmail: e["userEmail"],
              userFullname: e["userName"]+" "+e["userSurname"],
              userId: e["userId"],
              userPhoneNumber: e["userPhone"],
              userRole: e["roleName"]
          );
          listConnections.add(model);
        }
      }
    });
    return listConnections;
  }



}
