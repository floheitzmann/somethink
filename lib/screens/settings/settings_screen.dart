import 'package:country/country.dart';
import 'package:flag/flag.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:somethink/app.dart';
import 'package:somethink/screens/settings/change_game_background_screen.dart';
import 'package:somethink/screens/settings/change_theme_screen.dart';
import 'package:somethink/theme/theme_provider.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeProvider>(context);
    var locale = Localizations.localeOf(context);
    Country? country;

    for (var entry in Countries.values) {
      if (entry.alpha2 == locale.languageCode.toUpperCase()) {
        country = entry;
      }
    }

    country ??= Countries.usa;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: IconTheme(
            data: Theme.of(context).iconTheme,
            child: const Icon(
              CupertinoIcons.arrow_left,
            ),
          ),
        ),
        title: Text(S.of(context).settingsTitle),
        titleTextStyle: Theme.of(context).textTheme.headline5,
      ),
      body: SafeArea(
        minimum: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              S.of(context).settingsThemeSubTitle,
              style: Theme.of(context).textTheme.subtitle1,
            ),
            Container(
              padding: const EdgeInsets.all(12),
              margin: const EdgeInsets.only(top: 6),
              decoration: BoxDecoration(
                color: theme.isDarkTheme()
                    ? darkBackgroundColor
                    : lightBackgroundColor,
                borderRadius: BorderRadius.circular(8),
              ),
              width: double.infinity,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        S.of(context).representationTitle,
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return const ChangeThemeScreen();
                              },
                            ),
                          );
                        },
                        child: Text(getCurrentThemeType(context)),
                      ),
                    ],
                  ),
                  const Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        S.of(context).gameBackgroundTitle,
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      GestureDetector(
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                const ChangeGameBackgroundScreen(),
                          ),
                        ).then((value) {
                          setState(() {});
                        }),
                        child: Container(
                          height: 16,
                          width: 16,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: colors[backgroundColorKey],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 25),
            Text(
              S.of(context).settingsLanguageSubTitle,
              style: Theme.of(context).textTheme.subtitle1,
            ),
            const SizedBox(height: 6),
            InkWell(
              borderRadius: BorderRadius.circular(8),
              onTap: () {
                showDialog(
                  barrierDismissible: false,
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      actionsPadding: EdgeInsets.zero,
                      shape: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide.none,
                      ),
                      title: Text(
                        S.of(context).languageAlertTitle,
                        textAlign: TextAlign.center,
                      ),
                      content: Text(
                        S.of(context).languageAlertContent,
                        style: Theme.of(context).textTheme.bodyText2,
                        textAlign: TextAlign.center,
                      ),
                      actionsAlignment: MainAxisAlignment.center,
                      actions: [
                        const Divider(color: Colors.grey, height: 1),
                        // InkWell(
                        //   onTap: () {
                        //     Navigator.pop(context);
                        //     Future.delayed(
                        //       const Duration(
                        //         milliseconds: 300,
                        //       ),
                        //     ).then(
                        //       (value) {
                        //         // PermissionHandler().openAppSettings();
                        //         // OpenSettings.openAppSetting();
                        //       },
                        //     );
                        //   },
                        //   child: Container(
                        //     width: double.infinity,
                        //     height: 48,
                        //     alignment: Alignment.center,
                        //     child: Text(
                        //       S.of(context).next,
                        //       style: const TextStyle(
                        //         fontWeight: FontWeight.bold,
                        //         // color: primary,
                        //       ),
                        //       textAlign: TextAlign.center,
                        //     ),
                        //   ),
                        // ),
                        // const Divider(color: Colors.grey, height: 1),
                        InkWell(
                          onTap: () => Navigator.pop(context),
                          child: Container(
                            width: double.infinity,
                            height: 48,
                            alignment: Alignment.center,
                            child: Text(
                              S.of(context).cancel,
                              style: Theme.of(context).textTheme.bodyText1,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                );
              },
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: theme.isDarkTheme()
                      ? darkBackgroundColor
                      : lightBackgroundColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(country.nationality),
                    Flag.fromString(
                      country.unLocode,
                      height: 16,
                      width: 20,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

String convertCountryCodeToEmoji(String countryCode) {
  return countryCode.toUpperCase().replaceAllMapped(
        RegExp(r'[A-Z]'),
        (match) => String.fromCharCode(match.group(0)!.codeUnitAt(0) + 127397),
      );
}

String getThemeTypeName(BuildContext context, ThemeMode mode) {
  switch (mode) {
    case ThemeMode.system:
      return S.of(context).representationAutomatically;
    case ThemeMode.light:
      return S.of(context).representationLight;
    case ThemeMode.dark:
      return S.of(context).representationDark;
  }
}

String getCurrentThemeType(BuildContext context) {
  final theme = Provider.of<ThemeProvider>(context);
  return getThemeTypeName(context, theme.mode);
}
