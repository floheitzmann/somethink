import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemePreference {
  // ignore: constant_identifier_names
  static const THEME_MODE = "THEMEMODE";

  void setThemeMode(ThemeMode mode) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(THEME_MODE, mode.name);
  }

  Future<ThemeMode> getThemeMode() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? mode = prefs.getString(THEME_MODE);

    print(mode);

    if (mode == null) {
      return ThemeMode.system;
    }

    return ThemeMode.values.where((element) => element.name == mode).first;
  }
}
