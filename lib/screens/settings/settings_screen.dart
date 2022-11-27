import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:somethink/app.dart';
import 'package:somethink/screens/settings/change_theme_screen.dart';
import 'package:somethink/theme/theme_provider.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeProvider>(context);

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
        title: Text(
          "Einstellungen",
          style: Theme.of(context).textTheme.headline5,
        ),
      ),
      body: SafeArea(
        minimum: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Theme",
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
                      const Text(
                        "Darstellung",
                        style: TextStyle(
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

String getThemeTypeName(BuildContext context, ThemeMode mode) {
  switch (mode) {
    case ThemeMode.system:
      return "Automatisch";
    case ThemeMode.light:
      return "Hell";
    case ThemeMode.dark:
      return "Dunkel";
  }
}

String getCurrentThemeType(BuildContext context) {
  final theme = Provider.of<ThemeProvider>(context);
  return getThemeTypeName(context, theme.mode);
}
