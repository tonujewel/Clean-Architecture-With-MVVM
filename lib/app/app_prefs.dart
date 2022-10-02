import 'package:clean_architecture_with_mvvm/presentation/resources/language_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

const PREF_KEY_LANG = "PREF_KEY_LANG";
const PREF_KEY_ONBOARDING_SCREEN = "PREF_KEY_ONBOARDING_SCREEN";
const PREF_KEY_IS_USER_LOGGED_IN = "PREF_KEY_IS_USER_LOGGED_IN";

class AppPreferences {
  SharedPreferences _sharedPreferences;
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
}
