import 'package:flutter/material.dart';

ColorScheme get appLightColorScheme => const ColorScheme.light(
    brightness: Brightness.light,
    primary: Color(0xFFED2C67),
    onPrimary: Colors.white,
    primaryContainer: Color(0xFFB3124E),
    onPrimaryContainer: Colors.white,
    secondary: Color(0xff3B0919),
    onSecondary: Colors.black,
    secondaryContainer: Color(0xff5C1B2D),
    onSecondaryContainer: Colors.black,
    outline: Colors.grey,
    outlineVariant: Color.fromRGBO(255, 255, 255, 0.53),
    error: Color(0xffCF6679),
    onError: Colors.red,
    surface: Colors.black12,
    onSurface: Colors.black);

ColorScheme get appDarkColorScheme => const ColorScheme.dark(
    brightness: Brightness.dark,
    primary: Color(0xFFED2C67),
    onPrimary: Colors.white,
    primaryContainer: Color(0xFFB3124E),
    onPrimaryContainer: Colors.white,
    secondary: Color(0xff3B0919),
    onSecondary: Colors.white,
    secondaryContainer: Color(0xff5C1B2D),
    onSecondaryContainer: Colors.white,
    outline: Color(0xFF272727),
    outlineVariant: Color.fromRGBO(255, 255, 255, 0.669),
    error: Color(0xffCF6679),
    onError: Colors.white,
    surface: Color(0xFF181818),
    onSurface: Colors.white);
