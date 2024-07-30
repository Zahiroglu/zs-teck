import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../companents/app_setting/screen_maps_setting.dart';
import '../companents/login/mobile/login_mobile_first_screen.dart';
import '../companents/login/mobile/mobile_lisance_screen.dart';
import '../companents/login/splashandwelcome/welcome_screen.dart';
import '../companents/main_screen/mobile/base_screen_mobile.dart';
class RouteHelper {
  /////////////////constants
  static const String wellcome = '/wellcome_screen';
  static const String mobileLisanceScreen = '/mobile_lisance';
  static const String mobileLoginFistScreen = '/mobileLoginFistScreen';
  static const String mobileMainScreen = '/mobileMainScreen';
  static const String mobileMapSettingMobile = '/mobileMapSettingMobile';

  /////////////////getLinks
  static String getWellComeScreen() => wellcome;
  static String getMobileLisanceScreen() => mobileLisanceScreen;
  static String getLoginMobileFirstScreen() => mobileLoginFistScreen;
  static String getMobileMainScreen() => mobileMainScreen;
  static String getwidgetMapSettingScreenMobile() => mobileMapSettingMobile;


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
      return const LoginMobileFirstScreen();
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

  ];
}