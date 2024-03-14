import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FontConstants {
  static const String fontFamily = "NewsCycle";
}

class FontWeightManager {
  static const FontWeight regular = FontWeight.w400;
  static const FontWeight bold = FontWeight.bold;
}

class FontSize {
  static double s8 = 8.0.sp;
  static double s9 = 9.0.sp;
  static double s10 = 10.0.sp;
  static double s11 = 11.0.sp;
  static double s12 = 12.0.sp;
  static double s13 = 13.0.sp;
  static double s14 = 14.0.sp;
  static double s15 = 15.0.sp;
  static double s16 = 16.0.sp;
  static double s17 = 17.0.sp;
  static double s18 = 18.0.sp;
  static double s20 = 20.0.sp;
  static double s24 = 24.0.sp;
  static double s28 = 28.0.sp;
  static double s32 = 32.0.sp;
  static double s36 = 36.0.sp;
  static double s40 = 40.0.sp;
  static double s44 = 44.0.sp;
  static double s48 = 48.0.sp;
  static double s52 = 52.0.sp;
  static double s56 = 57.0.sp;
  static double s60 = 60.0.sp;
  static double s64 = 64.0.sp;
  static double s68 = 68.0.sp;
}

TextStyle _getTextStyle(
  double fontSize,
  FontWeight fontWeight,
  Color color, {
  TextDecoration? decoration,
}) {
  return TextStyle(
    fontSize: fontSize,
    fontFamily: FontConstants.fontFamily,
    fontWeight: fontWeight,
    color: color,
    decoration: decoration,
  );
}

/// regular NewsCycle font style
TextStyle getRegularTextStyle({
  double fontSize = 12.0,
  required Color color,
  TextDecoration? decoration,
}) {
  return _getTextStyle(
    fontSize,
    FontWeightManager.regular,
    color,
    decoration: decoration,
  );
}

/// bold NewsCycle font style
TextStyle getBoldTextStyle({
  double fontSize = 12.0,
  required Color color,
  TextDecoration? decoration,
}) {
  return _getTextStyle(
    fontSize,
    FontWeightManager.bold,
    color,
    decoration: decoration,
  );
}
