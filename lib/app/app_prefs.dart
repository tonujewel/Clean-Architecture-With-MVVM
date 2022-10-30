import 'package:clean_architecture_with_mvvm/presentation/resources/language_manager.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

const PREF_KEY_LANG = "PREF_KEY_LANG";
const PREF_KEY_ONBOARDING_SCREEN = "PREF_KEY_ONBOARDING_SCREEN";
const PREF_KEY_IS_USER_LOGGED_IN = "PREF_KEY_IS_USER_LOGGED_IN";

class AppPreferences {
  final SharedPreferences _sharedPreferences;
  AppPreferences(this._sharedPreferences);

  Future<String> getAppLanguage() async {
    // ....... LANGUAGE ....... ///
    String? language = _sharedPreferences.getString(PREF_KEY_LANG);

    if (language != null && language.isNotEmpty) {
      return language;
    } else {
      return LanguageType.ENGLISH.getValue();
    }
  }

  Future<void> setLanguageChanges() async {
    String currentLanguage = await getAppLanguage();
    if (currentLanguage == LanguageType.ARABIK.getValue()) {
      // save prefs with english langs
      _sharedPreferences.setString(
          PREF_KEY_LANG, LanguageType.ENGLISH.getValue());
    } else {
      _sharedPreferences.setString(
          PREF_KEY_LANG, LanguageType.ARABIK.getValue());
    }
  }

  Future<Locale> getLocal() async {
    String currentLanguage = await getAppLanguage();
    if (currentLanguage == LanguageType.ARABIK.getValue()) {
      //  return arabic local
      return ARABIK_LOCALE;
    } else {
      //  return english local
      return ENGLISH_LOCALE;
    }
  }

  // ....... ON BOARDING ....... ///
  Future<void> setOnBoardingScreenViewed() async {
    _sharedPreferences.setBool(PREF_KEY_ONBOARDING_SCREEN, true);
  }

  Future<bool> isOnBoardingScreenViewed() async {
    return _sharedPreferences.getBool(PREF_KEY_ONBOARDING_SCREEN) ?? false;
  }

  // ....... LOGIN ....... ///
  Future<void> setIsUserLoggedIn() async {
    _sharedPreferences.setBool(PREF_KEY_IS_USER_LOGGED_IN, true);
  }

  Future<bool> isUserLoggedIn() async {
    return _sharedPreferences.getBool(PREF_KEY_IS_USER_LOGGED_IN) ?? false;
  }

  Future<void> logout() async {
    await _sharedPreferences.remove(PREF_KEY_IS_USER_LOGGED_IN);
  }
}
