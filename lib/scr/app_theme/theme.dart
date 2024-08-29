import 'package:auth_app_structure/scr/app_theme/color_scheme.dart';
import 'package:auth_app_structure/scr/app_theme/text_theme.dart';
import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  factory AppTheme() {
    return instance;
  }

  static final AppTheme instance = AppTheme._();

  ThemeData get darkTheme => ThemeData(
        useMaterial3: true,
        textTheme: appTextTheme,
        colorScheme: appDarkColorScheme,
      );
  ThemeData get lightTheme => ThemeData(
        useMaterial3: true,
        textTheme: appTextTheme,
        colorScheme: appLightColorScheme,
      );
}
