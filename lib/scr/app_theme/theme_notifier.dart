import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeNotifier extends ChangeNotifier {
  ThemeMode _themeMode;
  ThemeMode get themeMode => _themeMode;

  ThemeNotifier(this._themeMode);

  void toggleTheme(bool isDark) async {
    _themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isDarkMode', isDark);
  }

  static Future<ThemeNotifier> create() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isDarkMode = prefs.getBool('isDarkMode') ?? false;
    return ThemeNotifier(isDarkMode ? ThemeMode.dark : ThemeMode.light);
  }
}
