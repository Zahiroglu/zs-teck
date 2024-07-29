import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import '../lang_constants.dart';
import '../localization_controller.dart';
import '../model_language.dart';

  Future<Map<String, Map<String, String>>> init() async {
    var box = await Hive.openBox('myLanguage');
    await Hive.openBox('theme');
    Get.lazyPut(() => LocalizationController(box));

    // Retrieving localized data
    Map<String, Map<String, String>> languages = {};
    for (LanguageModel languageModel in LangConstants.languages) {
      String jsonStringValues = await rootBundle.loadString('language/${languageModel.languageCode}.json');
      Map<String, dynamic> mappedJson = json.decode(jsonStringValues);
      Map<String, String> jsona = {};

      mappedJson.forEach((key, value) {
        jsona[key] = value.toString();
      });
      languages['${languageModel.languageCode}_${languageModel.countryCode}'] =
          jsona;
    }

    return languages;
  }
