import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:somethink/main.dart';
import 'package:somethink/screens/home_screen.dart';
import 'package:somethink/theme/theme_provider.dart';
import 'package:somethink/theme/theme_styles.dart';

final darkBackgroundColor = Colors.grey.shade900;
final lightBackgroundColor = Colors.grey.shade50;

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  var window = WidgetsBinding.instance.window;
  var provider = ThemeProvider();
  var brightness = SchedulerBinding.instance.window.platformBrightness;

  @override
  void initState() {
    window.onPlatformBrightnessChanged = () {
      isDarkMode = window.platformBrightness == Brightness.dark;
    };

    getCurrentAppTheme();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) {
        return provider;
      },
      child: Consumer<ThemeProvider>(
        builder: (context, value, child) {
          return MaterialApp(
            theme: Styles.themeData(context, ThemeMode.light),
            darkTheme: Styles.themeData(context, ThemeMode.dark),
            themeMode: provider.mode,
            home: const HomeScreen(),
          );
        },
      ),
    );
  }

  void getCurrentAppTheme() async {
    provider.themeMode = await provider.preference.getThemeMode();
  }
}
