import 'package:clean_architecture_with_mvvm/presentation/color_manager.dart';
import 'package:flutter/material.dart';

ThemeData getApplicationTheme() {
  return ThemeData(
      // main color of the app
      primaryColor: ColorManager.primar,
      primaryColorLight: ColorManager.primaryOpacity70,
      primaryColorDark: ColorManager.darkPrimary,
      disabledColor: ColorManager.grey1,
      colorScheme:
          ColorScheme.fromSwatch().copyWith(secondary: ColorManager.grey)

      // card view theme

      // appbar theme

      // button theme

      // text theme

      // input decoration theme (text form field)
      );
}
