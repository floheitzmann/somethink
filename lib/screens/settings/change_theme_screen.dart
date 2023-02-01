import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:somethink/app.dart';
import 'package:somethink/screens/settings/settings_screen.dart';
import 'package:somethink/theme/theme_provider.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ChangeThemeScreen extends StatefulWidget {
  const ChangeThemeScreen({super.key});

  @override
  State<ChangeThemeScreen> createState() => _ChangeThemeScreenState();
}

class _ChangeThemeScreenState extends State<ChangeThemeScreen> {
  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeProvider>(context);
    int count = 0;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(S.of(context).representationTitle),
        titleTextStyle: Theme.of(context).textTheme.headline5,
        leadingWidth: Platform.isAndroid ? 0 : 56,
        leading: Platform.isAndroid
            ? Container()
            : IconButton(
                onPressed: () => Navigator.pop(context),
                icon: IconTheme(
                  data: Theme.of(context).iconTheme,
                  child: const Icon(
                    CupertinoIcons.arrow_left,
                  ),
                ),
              ),
      ),
      body: SafeArea(
        minimum: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
                children: ThemeMode.values.map((mode) {
                  count++;
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        child: InkWell(
                          onTap: () => theme.themeMode = mode,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                getThemeTypeName(context, mode),
                                style: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              if (theme.mode == mode)
                                const Icon(
                                  Icons.check,
                                  size: 16,
                                ),
                            ],
                          ),
                        ),
                      ),
                      if (count < ThemeMode.values.length) const Divider(),
                    ],
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 25),
            Text(
              S.of(context).gameBackgroundTitle.toUpperCase(),
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
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              //  margin: const EdgeInsets.only(top: 6),
              decoration: BoxDecoration(
                color: theme.isDarkTheme()
                    ? darkBackgroundColor
                    : lightBackgroundColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Wrap(
                spacing: 10,
                children: colors.entries
                    .map(
                      (entry) => InkWell(
                        onTap: () {
                          setState(() {
                            backgroundColorKey = entry.key;
                            _saveBackgroundColor(entry.key);
                          });
                        },
                        child: Container(
                          height: 26,
                          width: 26,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            border: (entry.key == backgroundColorKey)
                                ? Border.all(
                                    color: theme.isDarkTheme()
                                        ? lighten(entry.value, 0.2)
                                        : darken(entry.value, 0.2),
                                    width: 2.5,
                                  )
                                : null,
                            color: entry.value,
                          ),
                          child: (entry.key == backgroundColorKey)
                              ? const Icon(
                                  Icons.check,
                                  size: 16,
                                  color: Colors.white,
                                )
                              : null,
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _saveBackgroundColor(String color) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("BACKGROUND_COLOR", color);
  }

  Color darken(Color color, [double amount = .1]) {
    assert(amount >= 0 && amount <= 1);

    final hsl = HSLColor.fromColor(color);
    final hslDark = hsl.withLightness((hsl.lightness - amount).clamp(0.0, 1.0));

    return hslDark.toColor();
  }

  Color lighten(Color color, [double amount = .1]) {
    assert(amount >= 0 && amount <= 1);

    final hsl = HSLColor.fromColor(color);
    final hslLight =
        hsl.withLightness((hsl.lightness + amount).clamp(0.0, 1.0));

    return hslLight.toColor();
  }
}
