import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:provider/provider.dart';
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

const collectionNames = [
  "questions_for_friends",
  "questions_to_the_partner",
  "conversation_starter",
  "speak_ones_mind"
];

const supportedLocales = [
  Locale("en", ""),
  Locale("de", ""),
];

Map<String, dynamic> collections = {};

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  final _provider = ThemeProvider();

  @override
  void initState() {
    WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
    FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

    loadCurrentAppTheme();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) {
        return _provider;
      },
      child: Consumer<ThemeProvider>(
        builder: (context, value, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
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
            supportedLocales: supportedLocales,
            theme: Styles.themeData(context, ThemeMode.light),
            darkTheme: Styles.themeData(context, ThemeMode.dark),
            themeMode: _provider.mode,
            home: const HomeScreen(),
          );
        },
      ),
    );
  }

  void loadCurrentAppTheme() async {
    _provider.themeMode = await _provider.preference.getThemeMode();
  }
}
