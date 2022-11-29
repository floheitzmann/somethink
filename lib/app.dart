import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:somethink/main.dart';
import 'package:somethink/screens/home_screen.dart';
import 'package:somethink/theme/theme_provider.dart';
import 'package:somethink/theme/theme_styles.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

final darkBackgroundColor = Colors.grey.shade900;
final lightBackgroundColor = Colors.grey.shade50;

var backgroundColorKey = "Maize Crayola";

const colors = {
  "Maize Crayola": Color(0xFFFAC748),
  "Malachite": Color(0xFF60DF55),
  "Neon Blue": Color(0xFF486FFA),
  "Capri": Color(0xFF48BCFA),
  "Magenta": Color(0xFFEB48FA),
  "Tart Orange": Color(0xFFFA4848),
  "Mandarin": Color(0xFFFA7848),
};

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
            localeListResolutionCallback: (locales, supportedLocales) {
              if (locales != null && locales.isNotEmpty) {
                if (locales.first.languageCode == 'de') {
                  return const Locale('de', '');
                } else {
                  return const Locale('en', '');
                }
              }
            },
            localizationsDelegates: const [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
              S.delegate,
            ],
            supportedLocales: const [
              Locale("en", ""),
              Locale("de", ""),
            ],
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
