import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class AppTranslations extends Translations {
  static Map<String, Map<String, String>> translations = {};

  static Future<void> loadTranslations() async {
    final List<String> locales = ['en_US', 'ar_DZ', 'fr_FR'];

    for (var locale in locales) {
      final jsonString = await rootBundle.loadString(
        'assets/lang/$locale.json',
      );
      final Map<String, dynamic> jsonMap = json.decode(jsonString);
      translations[locale] = jsonMap.map(
        (key, value) => MapEntry(key, value.toString()),
      );
    }
  }

  @override
  Map<String, Map<String, String>> get keys => translations;
}
