import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:zs_teck/routs/rout_controller.dart';
import 'package:zs_teck/services/local_databases_services/models/model_downloads.dart';
import 'package:zs_teck/thema/thema_controller.dart';
import 'package:zs_teck/thema/theme_constants.dart';
import 'companents/login/models/logged_usermodel.dart';
import 'companents/login/models/model_company.dart';
import 'companents/login/models/model_regions.dart';
import 'companents/login/models/model_token.dart';
import 'companents/login/models/model_userconnnection.dart';
import 'companents/login/models/model_userspormitions.dart';
import 'companents/login/models/user_model.dart';
import 'language/lang_constants.dart';
import 'language/localization_controller.dart';
import 'language/utils/messages.dart';
import 'language/utils/dep.dart' as dep;

Future<void>  main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: const FirebaseOptions(apiKey: 'AIzaSyDqqMQWeXsMyIOx-km6fzc13pdEao8T0VM',
      appId: '1:324780889406:android:0763c770939b3055ea086f',messagingSenderId: '324780889406',
      projectId: 'zsteck-d3f7c'));
  await Hive.initFlutter();
  Map<String, Map<String, String>> languages = await dep.init();
  //sonuncu HiveType 37-di
  Hive.registerAdapter(LoggedUserModelAdapter());
  Hive.registerAdapter(CompanyModelAdapter());
  Hive.registerAdapter(ModelRegionsAdapter());
  Hive.registerAdapter(TokenModelAdapter());
  Hive.registerAdapter(ModelUserConnectionAdapter());
  Hive.registerAdapter(ModelUserPermissionsAdapter());
  Hive.registerAdapter(UserModelAdapter());
  Hive.registerAdapter(ModelModuleAdapter());
  Hive.registerAdapter(ModelDownloadsAdapter());

  runApp(MyApp(languages: languages));

}


class MyApp extends StatefulWidget {
  final Map<String, Map<String, String>> languages;
  const MyApp({super.key,required this.languages});
  @override
  State<MyApp> createState() => _MyAppState();
}


class _MyAppState extends State<MyApp> with WidgetsBindingObserver{

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {

    bool isUpDestroyed=state==AppLifecycleState.detached;
    // TODO: implement didChangeAppLifecycleState
    super.didChangeAppLifecycleState(state);
  }

  @override
  Widget build(BuildContext context) {
    return  GetBuilder<LocalizationController>(builder: (localizationController){
      return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        darkTheme: darkTheme,
        theme: Get.put(ThemaController()).isDark.value
            ? darkTheme
            : lightTheme,
        themeMode: Get.put(ThemaController()).isDark.value
            ? ThemeMode.dark
            : ThemeMode.light,
        locale: localizationController.locale,
        translations: Messages(languages: widget.languages),
        fallbackLocale: Locale(LangConstants.languages[0].languageCode,
            LangConstants.languages[0].countryCode),
        initialRoute: RouteHelper.getWellComeScreen(),
        //initialRoute: RouteHelper.getMobileMainScreen(),
        getPages: RouteHelper.routes,
        defaultTransition: Transition.topLevel,
      );
    });
  }


}

