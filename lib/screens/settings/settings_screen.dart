import 'dart:io';

import 'package:country/country.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:somethink/app.dart';
import 'package:somethink/screens/settings/change_theme_screen.dart';
import 'package:somethink/theme/theme_provider.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:somethink/widgets/topic_button.dart';
import 'package:url_launcher/url_launcher_string.dart';

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
        leadingWidth: Platform.isAndroid ? 0 : 56,
        leading: Platform.isAndroid
            ? Container()
            : IconButton(
                onPressed: () => Navigator.pop(context),
                icon: IconTheme(
                  data: Theme.of(context).iconTheme,
                  child: const Icon(CupertinoIcons.clear),
                ),
              ),
        title: Text(S.of(context).settingsTitle),
        titleTextStyle: Theme.of(context).textTheme.headline5,
      ),
      body: SafeArea(
        minimum: const EdgeInsets.all(15),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                S.of(context).app,
                style: Theme.of(context).textTheme.subtitle1!.copyWith(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: theme.isDarkTheme()
                          ? Colors.grey.shade300
                          : Colors.grey.shade700,
                    ),
              ),
              const SizedBox(height: 6),
              Ink(
                decoration: BoxDecoration(
                  color: theme.isDarkTheme()
                      ? darkBackgroundColor
                      : lightBackgroundColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    TopicButton(
                      label: S.of(context).representationTitle,
                      color: const Color(0xFF17b355),
                      icon: const Icon(
                        Icons.color_lens_outlined,
                        size: 20,
                        color: Colors.white,
                      ),
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return const ChangeThemeScreen();
                          },
                        ),
                      ),
                      isTop: true,
                      topRadius: 10,
                    ),
                    TopicButton(
                      label: S.of(context).settingsLanguageSubTitle,
                      color: Colors.blue,
                      icon: const Icon(
                        Icons.language,
                        size: 20,
                        color: Colors.white,
                      ),
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
                                InkWell(
                                  onTap: () => Navigator.pop(context),
                                  child: Container(
                                    width: double.infinity,
                                    height: 48,
                                    alignment: Alignment.center,
                                    child: Text(
                                      S.of(context).cancel,
                                      style:
                                          Theme.of(context).textTheme.bodyText1,
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      isBottom: true,
                      bottomRadius: 10,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 25),
              Text(
                S.of(context).general,
                style: Theme.of(context).textTheme.subtitle1!.copyWith(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: theme.isDarkTheme()
                          ? Colors.grey.shade300
                          : Colors.grey.shade700,
                    ),
              ),
              const SizedBox(height: 6),
              Ink(
                decoration: BoxDecoration(
                  color: theme.isDarkTheme()
                      ? darkBackgroundColor
                      : lightBackgroundColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    TopicButton(
                      label: S.of(context).privacyPolicy,
                      color: const Color(0xFFf64c2d),
                      icon: const Icon(
                        Icons.lock_outline_sharp,
                        size: 20,
                        color: Colors.white,
                      ),
                      onTap: () {
                        launchUrlString(
                          "https://heitzmann.wtf/somethink-app/privacy-policiy/",
                        );
                      },
                      isTop: true,
                      topRadius: 10,
                    ),
                    // TopicButton(
                    //   label: "Nutzungsbedingungen",
                    //   color: const Color(0xFFf3a885),
                    //   icon: const Icon(
                    //     Icons.article_rounded,
                    //     size: 20,
                    //     color: Colors.white,
                    //   ),
                    //   onTap: () {
                    //     print("DD");
                    //   },
                    // ),
                    TopicButton(
                      label: S.of(context).rateTheApp,
                      color: const Color(0xFFf8b437),
                      icon: const Icon(
                        Icons.star,
                        size: 20,
                        color: Colors.white,
                      ),
                      onTap: () {
                        if (Platform.isIOS) {
                          launchUrlString(
                              "https://itunes.apple.com/app/somethink/id6444685257?mt=8&action=write-review");
                        } else if (Platform.isAndroid) {
                          // todo: add also
                        }
                      },
                    ),
                    // TopicButton(
                    //   label: "Credits",
                    //   color: Color(0xFF5e7bc7),
                    //   icon: const Icon(
                    //     Icons.code,
                    //     size: 20,
                    //     color: Colors.white,
                    //   ),
                    //   onTap: () {
                    //     print("FF");
                    //   },
                    // ),
                    TopicButton(
                      label: S.of(context).visitDiscord,
                      color: Colors.black,
                      icon: const Icon(
                        Icons.discord,
                        size: 20,
                        color: Colors.white,
                      ),
                      onTap: () {
                        launchUrlString("https://discord.gg/VCr3hacctM");
                      },
                      isBottom: true,
                      bottomRadius: 10,
                    ),
                  ],
                ),
              ),
              const Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 12),
                  child: Text(
                    version,
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
            ],
          ),
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
