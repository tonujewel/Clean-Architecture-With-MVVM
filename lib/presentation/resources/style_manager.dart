import 'package:flutter/material.dart';

import 'font_manager.dart';

TextStyle _getTextStyle(
    double fontSize, String fontFamily, FontWeight fontWeight, Color color) {
  return TextStyle(
    fontSize: fontSize,
    fontFamily: fontFamily,
    color: color,
    fontWeight: fontWeight,
  );
}

// Regular Text style
TextStyle getRegularTextStyle({
  double fontSize = FontSize.s12,
  required Color color,
}) {
  return _getTextStyle(
    fontSize,
    FontConstant.fontFamily,
    FontWeightManager.regular,
    color,
  );
}

// Light Text style
TextStyle getLightTextStyle({
  double fontSize = FontSize.s12,
  required Color color,
}) {
  return _getTextStyle(
    fontSize,
    FontConstant.fontFamily,
    FontWeightManager.light,
    color,
  );
}

// Bold Text style
TextStyle getBoldTextStyle({
  double fontSize = FontSize.s12,
  required Color color,
}) {
  return _getTextStyle(
    fontSize,
    FontConstant.fontFamily,
    FontWeightManager.bold,
    color,
  );
}

// Semi Bold Text style
TextStyle getSemiBoldTextStyle({
  double fontSize = FontSize.s12,
  required Color color,
}) {
  return _getTextStyle(
    fontSize,
    FontConstant.fontFamily,
    FontWeightManager.semiBold,
    color,
  );
}

// Medium Text style
TextStyle getMediumTextStyle({
  double fontSize = FontSize.s12,
  required Color color,
}) {
  return _getTextStyle(
    fontSize,
    FontConstant.fontFamily,
    FontWeightManager.medium,
    color,
  );
}
