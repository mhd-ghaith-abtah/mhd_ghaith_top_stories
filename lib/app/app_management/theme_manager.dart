import 'package:flutter/material.dart';
import 'package:mhd_ghaith_top_stories/app/app_management/color_manager.dart';
import 'package:mhd_ghaith_top_stories/app/app_management/font_manager.dart';

ThemeData getApplicationTheme() => ThemeData(
      useMaterial3: true,
      colorSchemeSeed: ColorManager.orange,
      appBarTheme: const AppBarTheme(
        color: ColorManager.lightBlue,
      ),
      inputDecorationTheme: InputDecorationTheme(
        helperMaxLines: 1,
        helperStyle: getRegularTextStyle(
          color: ColorManager.navy,
          fontSize: FontSize.s14,
        ),
        errorMaxLines: 2,
        hintStyle: getRegularTextStyle(
          color: ColorManager.grey,
          fontSize: FontSize.s14,
        ),
        labelStyle: getBoldTextStyle(
          color: ColorManager.grey,
          fontSize: FontSize.s14,
        ),
        errorStyle: getRegularTextStyle(color: ColorManager.red),
      ),
    );
