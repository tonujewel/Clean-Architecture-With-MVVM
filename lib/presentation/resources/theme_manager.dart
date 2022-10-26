import 'package:flutter/material.dart';
import 'style_manager.dart';
import 'color_manager.dart';
import 'font_manager.dart';
import 'values_manager.dart';

ThemeData getApplicationTheme() {
  return ThemeData(
    // main color of the app
    primaryColor: ColorManager.primary,
    primaryColorLight: ColorManager.primaryOpacity70,
    primaryColorDark: ColorManager.darkPrimary,
    disabledColor: ColorManager.grey1,
    splashColor: ColorManager.primaryOpacity70, // ripple color
    colorScheme:
        ColorScheme.fromSwatch().copyWith(secondary: ColorManager.grey),

    // card view theme
    cardTheme: CardTheme(
      color: ColorManager.white,
      shadowColor: ColorManager.grey,
      elevation: AppSize.s4,
    ),

    // App bar theme
    appBarTheme: AppBarTheme(
        centerTitle: true,
        color: ColorManager.primary,
        elevation: AppSize.s4,
        shadowColor: ColorManager.primaryOpacity70,
        titleTextStyle: getRegularTextStyle(
          color: ColorManager.white,
          fontSize: FontSize.s16,
        )),

    // Button theme
    buttonTheme: ButtonThemeData(
      shape: const StadiumBorder(),
      disabledColor: ColorManager.grey,
      buttonColor: ColorManager.primary,
      splashColor: ColorManager.primaryOpacity70,
    ),

    // Elevated button theme
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        textStyle: getRegularTextStyle(color: ColorManager.white),
        backgroundColor: ColorManager.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSize.s12),
        ),
      ),
    ),

    // text theme
    textTheme: TextTheme(
      headline1: getSemiBoldTextStyle(
          color: ColorManager.darkGrey, fontSize: FontSize.s16),
      headline2: getRegularTextStyle(
          color: ColorManager.white, fontSize: FontSize.s16),
      headline3: getRegularTextStyle(
          color: ColorManager.primary, fontSize: FontSize.s16),
      subtitle1: getMediumTextStyle(
          color: ColorManager.lightGrey, fontSize: FontSize.s14),
      subtitle2: getMediumTextStyle(
          color: ColorManager.primary, fontSize: FontSize.s14),
      caption: getRegularTextStyle(color: ColorManager.grey1),
      bodyText1: getRegularTextStyle(color: ColorManager.grey),
    ),
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: const EdgeInsets.all(AppSize.s4),
      hintStyle: getRegularTextStyle(color: ColorManager.grey1),
      labelStyle: getRegularTextStyle(color: ColorManager.darkGrey),
      // error
      errorStyle: getRegularTextStyle(color: ColorManager.error),

      // enable border
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: ColorManager.grey, width: AppSize.s1_5),
        borderRadius: const BorderRadius.all(Radius.circular(AppSize.s4)),
      ),

      // Focus border
      focusedBorder: OutlineInputBorder(
        borderSide:
            BorderSide(color: ColorManager.primary, width: AppSize.s1_5),
        borderRadius: const BorderRadius.all(Radius.circular(AppSize.s4)),
      ),

      // Focus border
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: ColorManager.error, width: AppSize.s1_5),
        borderRadius: const BorderRadius.all(Radius.circular(AppSize.s4)),
      ),

      //Focus border
      focusedErrorBorder: OutlineInputBorder(
        borderSide:
            BorderSide(color: ColorManager.primary, width: AppSize.s1_5),
        borderRadius: const BorderRadius.all(Radius.circular(AppSize.s4)),
      ),
    ),
  );
}
