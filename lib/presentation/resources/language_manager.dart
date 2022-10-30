import 'package:flutter/material.dart';

enum LanguageType { ENGLISH, ARABIK }

const String ENGLISH = 'en';
const String ARABIK = 'ar';
const String ASSET_PATH_LOCALE = 'assets/translations';
const Locale ARABIK_LOCALE = Locale('ar', 'SA');
const Locale ENGLISH_LOCALE = Locale('en', 'US');

extension LanguageTypeExtension on LanguageType {
  String getValue() {
    switch (this) {
      case LanguageType.ENGLISH:
        return ENGLISH;
      case LanguageType.ARABIK:
        return ARABIK;
    }
  }
}
