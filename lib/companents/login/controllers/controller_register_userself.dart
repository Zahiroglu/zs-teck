import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:zs_teck/companents/new_models/company_model.dart';
import 'package:zs_teck/companents/new_models/user_model.dart';
import 'package:zs_teck/helpers/dialog_helper.dart';
import 'package:zs_teck/routs/rout_controller.dart';

import '../../../global_widgets/simple_info_dialog.dart';

class ControllerRegisterUserself extends GetxController {
  TextEditingController cttextDviceId = TextEditingController();
  RxBool cttextDviceIdError = false.obs;
  TextEditingController cttextUsername = TextEditingController();
  RxBool cttextUsernameError = false.obs;
  TextEditingController cttextPassword = TextEditingController();
  RxBool cttextPasswordError = false.obs;
  TextEditingController cttextEmail = TextEditingController();
  TextEditingController cttextAd = TextEditingController();
  RxBool cttextAdError = false.obs;
  TextEditingController cttextSoyad = TextEditingController();
  RxBool cttextSoyadError = false.obs;
  TextEditingController cttextCode = TextEditingController();
  RxBool cttextCodeError = false.obs;
  TextEditingController cttextTelefon = TextEditingController();
  RxBool cttextTelefonError = false.obs;
  TextEditingController cttextDogumTarix = TextEditingController();
  RxString selectedDate = DateTime.now().toString().substring(0, 10).obs;
  RxBool genderSelect = true.obs;
  RxList<ModelRegion> listRegionlar =
      List<ModelRegion>.empty(growable: true).obs;
  final selectedCompany = Rxn<CompanyModel>();
  final selectedRegion = Rxn<ModelRegion>();
  RxBool regionSecildi = false.obs;
  RxBool dataLoading = false.obs;
  RxString moduleName = "".obs;
  RxString roleName = "".obs;

  @override
  void onInit() {
    // TODO: implement onInit
    callDatePickerFirst();
    super.onInit();
  }

  Future<void> getCompanyDetails(
    String lisanceId,
    String token,
    String companyId,
    String moduleId,
    String roleId,
  ) async {
    dataLoading.value = true;
    update();
    await FirebaseFirestore.instance
        .collection('db_companies')
        .where('companyId', isEqualTo: companyId)
        .get()
        .then((QuerySnapshot querySnapshot) async {
      if (querySnapshot.docs.isEmpty) {
        // bu halda xeta bas verir
      } else {
        await FirebaseFirestore.instance
            .collection('db_companies')
            .doc(querySnapshot.docs.first["companyId"])
            .collection("regions")
            .get()
            .then((querySnapshot2) {
          for (var reg in querySnapshot2.docs) {
            ModelRegion modela = ModelRegion(
                regionName: reg["regionName"],
                regionAdress: reg["regionAdress"],
                regionId: int.tryParse(reg["regionId"].toString()),
                regionCode: reg["regionCode"],
                regionLatitude:
                    double.tryParse(reg["regionLatitude"].toString()),
                regionLongitude:
                    double.tryParse(reg["regionLongitude"].toString()));
            listRegionlar.add(modela);
          }
          selectedCompany.value = CompanyModel(
            companyId: querySnapshot.docs.first["companyId"],
            companyAdress: querySnapshot.docs.first["companyAdress"],
            companyMail: querySnapshot.docs.first["companyMail"],
            companyName: querySnapshot.docs.first["companyName"],
            companyPhone: querySnapshot.docs.first["companyPhone"],
            copmanyBaseUrl: querySnapshot.docs.first["copmanyBaseUrl"],
            modelRegion: listRegionlar,
          );
        });
      }
    });
    await getModelInfo(lisanceId, token, companyId, moduleId, roleId);
    if (listRegionlar.length == 1) {
      selectedRegion.value = listRegionlar.first;
      regionSecildi.value = true;
    }
    update();
  }

  Future<void> getModelInfo(
    String lisanceId,
    String token,
    String companyId,
    String moduleId,
    String roleId,
  ) async {
    String languageIndex = await getLanguageIndex();
    print("languageIndex : " + languageIndex.toString());
    print("moduleId : " + moduleId.toString());
    update();
    await FirebaseFirestore.instance
        .collection('db_modules')
        .doc(languageIndex)
        .collection("modules")
        .where("moduleId", isEqualTo: moduleId)
        .get()
        .then((QuerySnapshot querySnapshot) async {
      if (querySnapshot.docs.isNotEmpty) {
        moduleName.value = querySnapshot.docs.first['moduleName'];
        await FirebaseFirestore.instance
            .collection('db_roles')
            .doc(languageIndex)
            .collection("roles")
            .where("roleId", isEqualTo: roleId)
            .get()
            .then((QuerySnapshot querySnapshot) async {
          if (querySnapshot.docs.isNotEmpty) {
            roleName.value = querySnapshot.docs.first['roleName'];
          }
        });
      }
    });
    dataLoading.value = false;
    update();
  }

  void changeSelectedRegion(ModelRegion val) {
    selectedRegion.value = val;
    regionSecildi.value = true;
    update();
  }

  void changeSelectedGender(bool val) {
    genderSelect.value = val;
    update();
  }

  void callDatePickerFirst() async {
    String day = "01";
    String ay = "01";
    var order = DateTime.now();
    if (order.day.toInt() < 10) {
      day = "0${order.day}";
    } else {
      day = order.day.toString();
    }
    if (order.month.toInt() < 10) {
      ay = "0${order.month}";
    } else {
      ay = order.month.toString();
    }
    selectedDate.value = "$day.$ay.${order.year}";
    cttextDogumTarix.text = "$day.$ay.${order.year}";
  }

  void callDatePicker() async {
    String day = "01";
    String ay = "01";
    var order = await getDate();
    if (order!.day.toInt() < 10) {
      day = "0${order.day}";
    } else {
      day = order.day.toString();
    }
    if (order.month.toInt() < 10) {
      ay = "0${order.month}";
    } else {
      ay = order.month.toString();
    }
    selectedDate.value = "$day.$ay.${order.year}";
    cttextDogumTarix.text = "$day.$ay.${order.year}";
  }

  Future<DateTime?> getDate() {
    return showDatePicker(
      context: Get.context!,
      initialDate: DateTime.now(),
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
      builder: (BuildContext context, Widget? child) {
        return child!;
      },
    );
  }

  Future<String> getLanguageIndex() async {
    return await Hive.box("myLanguage").get("langCode") ?? "az";
  }

  Future<void> regigisterUser(String lisanceId, String token, String companyId, String moduleId, String roleId, String phoneId) async {
    final connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult != ConnectivityResult.none) {
      DialogHelper.showLoading("qeydiyyatYoxlanilir".tr);
      CollectionReference ref = FirebaseFirestore.instance.collection('db_users');
      String docId = ref.doc().id;
      UserModel model = UserModel(
        userId: docId,
        temKod: cttextCode.text ?? "Bos",
        userName: cttextAd.text ?? "Bos",
        userSurname: cttextSoyad.text ?? "Bos",
        userbirthDay: selectedDate.toString(),
        userEmail: cttextEmail.text,
        userGender: genderSelect.value ? 1 : 0,
        userPhone: cttextTelefon.text,
        usingStatus: false,
        followingStatus: false.toString(),
        compId: companyId,
        userRegionId: selectedRegion.value!.regionId,
        userRegionName: selectedRegion.value!.regionName,
        moduleId: moduleId,
        moduleName: moduleName.value,
        roleId: roleId,
        roleName: roleName.value,
        permitions: [],
        userConnectionsId: [],
        userPhoneId: phoneId,
        fireToken: token,
        registerDate: DateTime.now().toIso8601String(),
      );
      await ref.doc(docId).set(model.toJson()).whenComplete(() {
        DialogHelper.hideLoading();
        Get.offNamed(RouteHelper.mobileLisanceScreen);
      });
    } else {
      Get.dialog(ShowInfoDialog(
        icon: Icons.network_locked_outlined,
        messaje: "internetError".tr,
        callback: () {
          Get.back();
        },
      ));
    }
  }
}
