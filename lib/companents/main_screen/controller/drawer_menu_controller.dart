import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart' as getx;
import 'package:get/get.dart';
import '../../../global_widgets/custom_responsize_textview.dart';
import '../../../global_widgets/sual_dialog.dart';
import '../../../helpers/checking_dvice_type.dart';
import '../../../services/local_databases_services/local_app_setting.dart';
import '../../../services/local_databases_services/local_db_downloads.dart';
import '../../../services/local_databases_services/local_users_services.dart';
import '../../../services/local_databases_services/models/model_appsetting.dart';
import '../../app_setting/setting_screen_mobile.dart';
import '../../dashbourd/dashbourd_screen_mobile.dart';
import '../../new_models/logged_usermodel.dart';
import '../drawer/model_drawerItems.dart';

class DrawerMenuController extends getx.GetxController {
  getx.RxList<SelectionButtonData> drawerMenus = List<SelectionButtonData>.empty(growable: true).obs;
  getx.RxInt selectedIndex = 0.obs;
  getSelectedIndex() => selectedIndex;
 // Widget getCurrentPage() => pageView;
  LocalUserServices userServices = LocalUserServices();
  getx.RxBool drawerCloused = true.obs;
  getx.RxBool isMenuExpended = true.obs;
  getx.RxBool aktivateHover = true.obs;
  CheckDviceType checkDviceType = CheckDviceType();
  int dviceType = 0;
  LocalAppSetting localAppSetting = LocalAppSetting();
  ModelAppSetting modelAppSetting = ModelAppSetting(mapsetting: null, girisCixisType: "map",userStartWork: false);
  //LocalBazalar localBazalar = LocalBazalar();
  LocalBaseDownloads localBaseDownloads = LocalBaseDownloads();
  //LocalBaseSatis localBaseSatis=LocalBaseSatis();
  //LocalGirisCixisServiz localGirisCixisServiz=LocalGirisCixisServiz();
  //late Rx<ModelSatisEmeliyyati> modelSatisEmeliyyat = ModelSatisEmeliyyati().obs;
  GlobalKey<ScaffoldState> keyScaff = GlobalKey(); // Create a key
  dynamic pageView =  SizedBox();


  @override
  void onInit() {
    initAllValues();
    pageView = DashborudScreenMobile(drawerMenuController: this);
    super.onInit();
  }

  void clousDrawer(){
    keyScaff.currentState!.closeDrawer();
    update();
  }

  void openDrawer(){
    keyScaff.currentState!.openDrawer();
    update();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  void initKeyForScafold(GlobalKey<ScaffoldState> key) {
    keyScaff=key;
    update();
  }

  Future<List<SelectionButtonData>> addPermisionsInDrawerMenu(LoggedUserModel loggedUser) async {
    print("logged user :"+loggedUser.toString());
    dviceType = checkDviceType.getDviceType();
    drawerMenus.clear();
    drawerMenus.forEach((element) {
      print("Drawr :"+element.label.toString());

    });
    SelectionButtonData dashboard = SelectionButtonData(
        icon: Icons.dashboard,
        label: "dashboard",
        activeIcon: Icons.dashboard_outlined,
        totalNotif: 0,
        statickField: false,
        isSelected: false,
        codename: "dashboard");
    SelectionButtonData buttondownloads = SelectionButtonData(
        icon: Icons.upcoming,
        label: "yuklemeler",
        activeIcon: Icons.upcoming_outlined,
        totalNotif: 0,
        statickField: false,
        isSelected: false,
        codename: "down");
    SelectionButtonData buttonstaticAboudAs = SelectionButtonData(
        icon: Icons.info_outline,
        label: "haqqimizda",
        activeIcon: Icons.info,
        totalNotif: 0,
        statickField: true,
        isSelected: false,
        codename: "about");
    SelectionButtonData buttonstaticPrivansyPolisy = SelectionButtonData(
        icon: Icons.lock_person_outlined,
        label: "privancypolicy",
        activeIcon: Icons.lock_person,
        totalNotif: 0,
        statickField: true,
        isSelected: false,
        codename: "privance");
    SelectionButtonData buttonstaticProfileSetting = SelectionButtonData(
        icon: Icons.settings_applications_outlined,
        label: "setting",
        activeIcon: Icons.settings_applications,
        totalNotif: 0,
        statickField: true,
        isSelected: false,
        codename: "setting");
    SelectionButtonData buttonLogOut = SelectionButtonData(
        icon: Icons.logout,
        label: "cixiset",
        activeIcon: Icons.logout,
        totalNotif: 0,
        statickField: true,
        isSelected: false,
        codename: "logout");
    drawerMenus.insert(0,dashboard);
    drawerMenus.add(buttonstaticProfileSetting);
    drawerMenus.insert(1,buttondownloads);
    if(checkIfTodayHasSales()){
      // SelectionButtonData buttonSatis = SelectionButtonData(
      //     icon: Icons.payments,
      //     label: "Sifarisler",
      //     activeIcon: Icons.payments_sharp,
      //     totalNotif: (modelSatisEmeliyyat.value.listSatis!.length+modelSatisEmeliyyat.value.listIade!.length+modelSatisEmeliyyat.value.listKassa!.length).toInt(),
      //     statickField: false,
      //     isSelected: false,
      //     codename: "sellDetal");
      //drawerMenus.insert(2,buttonSatis);
    }
    if (loggedUser.userModel != null) {
      for (var element in loggedUser.userModel!.permitions!.where((e)=>e.isMenuItems==true)) {
        IconData icon = IconData(int.parse(element.iconMenu.toString()), fontFamily: 'MaterialIcons');
         IconData iconSelected = IconData(int.parse(element.iconSelected.toString()), fontFamily: 'MaterialIcons');
        SelectionButtonData buttonData = SelectionButtonData(
            icon: icon,
            label: element.perValue,
            activeIcon: iconSelected,
            totalNotif: 0,
            statickField: false,
            isSelected: false,
            codename: element.perCode);
        drawerMenus.add(buttonData);
      }
    }
    drawerMenus.add(buttonstaticAboudAs);
    drawerMenus.add(buttonstaticPrivansyPolisy);
    drawerMenus.add(buttonLogOut);
    update();
    return drawerMenus;
  }

  changeExpendedOrNot() {
    dviceType = checkDviceType.getDviceType();
    if (dviceType == 3 || dviceType == 2) {
      if (aktivateHover.isTrue) {
        isMenuExpended.value = true;
      } else {
        isMenuExpended.value = false;
      }
      update();
    }
  }

  changeHover() {
    aktivateHover.toggle();
    if (!aktivateHover.value) {
      isMenuExpended.value = false;
    } else {
      isMenuExpended.value = true;
    }
    update();
  }

  Widget getItemsMenu(Function(bool clouse) closeDrawer, bool isDesk, GlobalKey<ScaffoldState> scaffoldkey) {
    keyScaff=scaffoldkey;
    if (!isDesk) {
      isMenuExpended = false.obs;
    }
    return MouseRegion(
      onEnter: (onEnter) => onClickEnter(true),
      onExit: (onExit) => onClickExit(true),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          isDesk
              ? Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          IconButton(
                              onPressed: () {
                                changeHover();
                              },
                              icon: const Icon(Icons.menu)),
                          isMenuExpended.isTrue
                              ? const SizedBox()
                              : const SizedBox(
                                  width: 10,
                                ),
                          isMenuExpended.isTrue
                              ? const SizedBox()
                              : CustomText(
                                  labeltext: "menular".tr,
                                  fontsize: 18,
                                  fontWeight: FontWeight.w600),
                        ],
                      ),
                    ),
                  ),
                )
              : const SizedBox(),
          isMenuExpended.isTrue
              ? const Divider(
                  height: 3,
                  color: Colors.grey,
                )
              : const SizedBox(),
          Expanded(
            flex: dviceType == 3 || dviceType == 2 ? 14 : 10,
            child: SingleChildScrollView(
              child: getx.Obx(() => Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: drawerMenus
                        .where((element) => element.statickField == false)
                        .map((model) => InkWell(
                              onTap: () {
                                changeExpendedOrNot();
                                changeSelectedIndex(drawerMenus.indexOf(model), model, isDesk);
                                closeDrawer.call(true);
                                scaffoldkey.currentState!.closeDrawer();
                              },
                              child: getx.Obx(() => itemsDrawer(model)),
                            ))
                        .toList(),
                  )),
            ),
          ),
          const Divider(
            height: 2,
            color: Colors.grey,
          ),
          Expanded(
            flex: dviceType == 3 || dviceType == 2 ? 5 : 5,
            child: SingleChildScrollView(
              child: getx.Obx(() => Column(
                    children: drawerMenus
                        .where((element) => element.statickField == true)
                        .map((model) => InkWell(
                              onTap: () {
                                changeExpendedOrNot();
                                changeSelectedIndex(drawerMenus.indexOf(model), model, isDesk);
                                closeDrawer.call(true);
                              },
                              child: getx.Obx(() => itemsDrawer(model)),
                            ))
                        .toList(),
                  )),
            ),
          ),
        ],
      ),
    );
  }

  AnimatedContainer itemsDrawer(SelectionButtonData model) {
    return AnimatedContainer(
      padding: selectedIndex.value == drawerMenus.indexOf(model)
          ? const EdgeInsets.all(1)
          : const EdgeInsets.all(0),
      margin: const EdgeInsets.only(left: 5, top: 5),
      decoration: model.codename == "logout"
          ? const BoxDecoration()
          : BoxDecoration(
              borderRadius: selectedIndex.value == drawerMenus.indexOf(model)
                  ? const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      bottomLeft: Radius.circular(20))
                  : null,
              color: selectedIndex.value == drawerMenus.indexOf(model)
                  ? Colors.blue.withOpacity(0.5)
                  : Colors.transparent,
              border: selectedIndex.value == drawerMenus.indexOf(model)
                  ? Border.all(color: Colors.black26, width: 0.2)
                  : null,
              shape: BoxShape.rectangle,
              boxShadow: selectedIndex.value == drawerMenus.indexOf(model)
                  ? [
                      BoxShadow(
                          color: Colors.white.withOpacity(0.5),
                          offset: const Offset(-2, 2),
                          blurRadius: 20,
                          spreadRadius: 1,
                        blurStyle: BlurStyle.outer
                      )
                    ]
                  : []),
      transformAlignment: Alignment.centerRight,
      duration: model.codename == "logout"
          ? const Duration(milliseconds: 1)
          : const Duration(milliseconds: 500),
      curve: Curves.linear,
      child: Padding(
        padding: model.statickField==true?const EdgeInsets.all(10.0).copyWith(bottom: 5,top: 5):const EdgeInsets.all(10.0).copyWith(top: 7,bottom: 7),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                isMenuExpended.isTrue
                    ? Tooltip(
                        waitDuration: const Duration(milliseconds: 100),
                        message: model.label!,
                        child: Icon(
                          size:
                              selectedIndex.value == drawerMenus.indexOf(model)
                                  ? 28
                                  : 24,
                          selectedIndex.value == drawerMenus.indexOf(model)
                              ? model.activeIcon
                              : model.icon,
                          color: model.codename == "logout"
                              ? Colors.red
                              : selectedIndex.value ==
                                      drawerMenus.indexOf(model)
                                  ? getx.Get.isDarkMode
                                      ? Colors.white
                                      : Colors.black
                                  : getx.Get.isDarkMode
                                      ? Colors.black
                                      : Colors.white,
                        ),
                      )
                    : Icon(
                        size: selectedIndex.value == drawerMenus.indexOf(model)
                            ? 28
                            : 24,
                        selectedIndex.value == drawerMenus.indexOf(model)
                            ? model.activeIcon
                            : model.icon,
                        color: model.codename == "logout"
                            ? Colors.red
                            : selectedIndex.value == drawerMenus.indexOf(model)
                                ? getx.Get.isDarkMode
                                    ? Colors.white
                                    : Colors.black
                                : getx.Get.isDarkMode
                                    ? Colors.black
                                    : Colors.white,
                      ),
                isMenuExpended.isTrue
                    ? const SizedBox()
                    : const SizedBox(
                        width: 5,
                      ),
                isMenuExpended.isTrue
                    ? const SizedBox()
                    : CustomText(
                        labeltext: model.label!,
                        color: model.codename == "logout"
                            ? Colors.red
                            : getx.Get.isDarkMode
                                ? Colors.white
                                : Colors.black,
                        fontsize:
                            selectedIndex.value == drawerMenus.indexOf(model)
                                ? 18
                                : 16,
                        fontWeight:
                            selectedIndex.value == drawerMenus.indexOf(model)
                                ? FontWeight.normal
                                : FontWeight.normal,
                      ),
                const Spacer(),
                isMenuExpended.isTrue
                    ? const SizedBox()
                    : model.totalNotif==0?SizedBox():DecoratedBox(
                  decoration: const BoxDecoration(
                    //color: Colors.grey.withOpacity(0.5),
                    shape: BoxShape.circle,

                  ),
                      child: Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: CustomText(
                            labeltext:model.totalNotif.toString(),
                            color: Colors.blue,
                            fontsize:
                                selectedIndex.value == drawerMenus.indexOf(model)
                                    ? 20
                                    : 18,
                            fontWeight:FontWeight.bold
                          ),
                      ),
                    ),
                SizedBox(width: 10,),
              ],
            ),
            model.statickField==true?SizedBox(height: 5,):SizedBox(),
          ],
        ),
      ),
    );
  }

  void changeIndexWhenLanguageChange() {
    if (drawerMenus.elementAt(selectedIndex.value).codename == "users") {
      pageView =  DashborudScreenMobile(drawerMenuController: this);
      changeSelectedIndex(selectedIndex.value, drawerMenus.elementAt(selectedIndex.value), true);
    }
  }

  changeSelectedIndex(int index, SelectionButtonData model, bool desktop) {
    selectedIndex.value = index;
    changeIndex(index, model, desktop);
    update();
  }


  bool checkIfTodayHasSales(){
  //   modelSatisEmeliyyat.value=localBaseSatis.getTodaySatisEmeliyyatlari();
  //   return modelSatisEmeliyyat.value.listKassa!.isNotEmpty|| modelSatisEmeliyyat.value.listIade!.isNotEmpty|| modelSatisEmeliyyat.value.listSatis!.isNotEmpty;
  //
    return false;
    }

  void logOut() {
    getx.Get.dialog(ShowSualDialog(
        messaje: "cixisucun".tr,
        callBack: (val) async {
          getx.Get.delete<DrawerMenuController>();
        //  localBazalar.deleteAllBases();
          if (Platform.isAndroid) {
            SystemNavigator.pop();
          } else if (Platform.isIOS) {
            exit(0);
          }
        }));
  }

  onClickEnter(bool bool) {
    if (aktivateHover.value) {
      isMenuExpended.value = false;
    }
  }

  onClickExit(bool bool) {
    if (aktivateHover.value) {
      isMenuExpended.value = true;
    }
  }

  Future<void> initAllValues() async {
    await userServices.init();
    await localAppSetting.init();
    await localBaseDownloads.init();
    addPermisionsInDrawerMenu(userServices.getLoggedUser());
    update();
  }

  Future<void> changeIndex(int drawerIndexdata, SelectionButtonData model, bool desktop) async {
    switch (model.codename) {
      case "dashboard":
       // pageView = DashborudScreenMobile(drawerMenuController: this);
        break;
      case "userspanel":
          //pageView = const UserPanelWindosScreen();

        break;
      case "setting":
        pageView =  SettingScreenMobile(drawerMenuController: this,);
      case "enter":
       // await localAppSetting.init();
       // modelAppSetting = await localAppSetting.getAvaibleMap();
       // if(modelAppSetting.userStartWork==true) {
       //   if (localBaseDownloads.getIfCariBaseDownloaded(userServices.getLoggedUser().userModel!.moduleId!)) {
       //     if (modelAppSetting.girisCixisType == "map") {
       //       pageView = const YeniGirisCixisMap();
       //     } else {
       //       pageView = ScreenGirisCixisReklam(drawerMenuController: this,);
       //     }
       //   } else {
       //     Get.dialog(ShowInfoDialog(
       //         messaje: "baseEmptyCari".tr,
       //         icon: Icons.mobiledata_off,
       //         callback: () {
       //           Get.back();
       //           update();
       //         }));
       //   }
       // }else{
       //   Get.dialog(ShowInfoDialog(
       //       messaje: "infoErrorStartWork".tr,
       //       icon: Icons.work_history,
       //       color: Colors.red,
       //       callback: () {
       //         Get.back();
       //         update();
       //       }));
      break;

    }
    selectedIndex.value = drawerIndexdata;
update();  }

}
