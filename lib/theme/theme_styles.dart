import 'package:flutter/material.dart';

class Styles {
  static ThemeData themeData(BuildContext context, ThemeMode mode) {
    bool isDarkTheme = mode == ThemeMode.dark;

    return ThemeData(
      brightness: isDarkTheme ? Brightness.dark : Brightness.light,
      scaffoldBackgroundColor:
          isDarkTheme ? Colors.black : Colors.grey.shade200,
      appBarTheme: AppBarTheme(
        elevation: 0,
        backgroundColor:
            isDarkTheme ? Colors.grey.shade900 : Colors.grey.shade50,
      ),
    );
  }
}
