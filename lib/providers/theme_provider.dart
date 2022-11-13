import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider with ChangeNotifier {
  bool loaded = false;
  bool _isDarkMode = false;
  SharedPreferences? _prefs;

  ThemeMode get themeMode => _isDarkMode ? ThemeMode.dark : ThemeMode.light;

  bool get isDarkMode => _isDarkMode;

  void loadTheme() async {
    _prefs = await SharedPreferences.getInstance();
    _isDarkMode = _prefs!.getBool("isDarkMode") ?? true; // default to dark mode
    loaded = true;
    notifyListeners();
  }

  void setThemeMode(ThemeMode themeMode) {
    _isDarkMode = themeMode == ThemeMode.dark;
    _prefs!.setBool("isDarkMode", _isDarkMode);
    notifyListeners();
  }
}
