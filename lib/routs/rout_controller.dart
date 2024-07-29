import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../companents/login/mobile/login_mobile_first_screen.dart';
import '../companents/login/mobile/mobile_lisance_screen.dart';
import '../companents/login/splashandwelcome/welcome_screen.dart';
class RouteHelper {
  /////////////////constants
  static const String wellcome = '/wellcome_screen';
  static const String mobileLisanceScreen = '/mobile_lisance';
  static const String mobileLoginFistScreen = '/mobileLoginFistScreen';

  /////////////////getLinks
  static String getWellComeScreen() => wellcome;
  static String getMobileLisanceScreen() => mobileLisanceScreen;
  static String getLoginMobileFirstScreen() => mobileLoginFistScreen;


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

  ];
}