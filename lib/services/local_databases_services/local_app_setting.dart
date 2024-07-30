import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:map_launcher/map_launcher.dart';

import 'models/model_appsetting.dart';

class LocalAppSetting {
  late Box appSettings = Hive.box("appSettings");

  Future<void> init() async {
    appSettings = await Hive.openBox("appSettings");
  }

  Future<void> addSelectedMyTypeToLocalDB(ModelAppSetting availableMap) async {
    print("changed setting value :"+availableMap.toString());
    await appSettings.clear();
    await appSettings.add(availableMap);
  }

  Future<ModelAppSetting> getAvaibleMap() async{
    ModelAppSetting model=ModelAppSetting(mapsetting: null, girisCixisType: "list",userStartWork: false);
    if(appSettings.values.firstOrNull!=null){
      model= await appSettings.values.firstOrNull;
    }
    return model;
  }



}
