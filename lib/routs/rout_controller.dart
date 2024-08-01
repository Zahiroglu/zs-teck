import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../companents/app_setting/screen_maps_setting.dart';
import '../companents/login/screens/app_permition_setting.dart';
import '../companents/login/screens/mobile_lisance_screen.dart';
import '../companents/login/screens/screen_user_self_register.dart';
import '../companents/login/splashandwelcome/welcome_screen.dart';
import '../companents/main_screen/mobile/base_screen_mobile.dart';
class RouteHelper {
  /////////////////constants
  static const String wellcome = '/wellcome_screen';
  static const String mobileLisanceScreen = '/mobile_lisance';
  static const String mobileLoginFistScreen = '/mobileLoginFistScreen';
  static const String mobileMainScreen = '/mobileMainScreen';
  static const String mobileMapSettingMobile = '/mobileMapSettingMobile';
  static const String screenUsersSelfRegister = '/screenUsersSelfRegister';

  /////////////////getLinks
  static String getWellComeScreen() => wellcome;
  static String getMobileLisanceScreen() => mobileLisanceScreen;
  static String getLoginMobileFirstScreen() => mobileLoginFistScreen;
  static String getMobileMainScreen() => mobileMainScreen;
  static String getwidgetMapSettingScreenMobile() => mobileMapSettingMobile;
  static String getScreenUsersSelfRegister() => screenUsersSelfRegister;


  static List<GetPage> routes = [

    GetPage(name: wellcome, page: () {
      return const WellCameScreen();
      return  Container();
    }),
    GetPage(
        name: mobileLisanceScreen,
        page: () {
      return  ScreenRequestCheckMobile();
      return  Container();
    }),
    GetPage(name: mobileLoginFistScreen, page: () {
      return const ScreenAppPermitionSetting();
      return  Container();
    }),
    GetPage(
   curve: Curves.bounceOut,
     transitionDuration: const Duration(milliseconds: 200),
     name: mobileMainScreen, page: () {
      return MainScreenMobile();
      return  Container();
    }),
    GetPage(
        transition: Transition.rightToLeft,
        transitionDuration: const Duration(milliseconds: 600),
        name: mobileMapSettingMobile, page: () {
      return  const ScreenMapsSetting();
      return  Container();
    }),
    GetPage(
        name: screenUsersSelfRegister, page: () {
      return   ScreenUsersSelfRegister(
        lisanceId: Get.arguments[0],
        token: Get.arguments[1],
        companyId: Get.arguments[2],
        moduleId: Get.arguments[3],
        roleId: Get.arguments[4],
        phoneId: Get.arguments[5],

      );
      return  Container();
    }),

  ];
}