import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:somethink/theme/theme_preference.dart';

class ThemeProvider with ChangeNotifier {
  ThemePreference preference = ThemePreference();
  ThemeMode _mode = ThemeMode.system;

  ThemeMode get mode => _mode;

  set themeMode(ThemeMode mode) {
    _mode = mode;
    preference.setThemeMode(mode);
    notifyListeners();
  }

  bool isDarkTheme() {
    if (mode == ThemeMode.system) {
      return SchedulerBinding.instance.window.platformBrightness ==
          Brightness.dark;
    } else {
      return mode == ThemeMode.dark;
    }
  }
}
