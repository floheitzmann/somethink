import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
        leading: IconButton(
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
                      InkWell(
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
                      if (count < ThemeMode.values.length) const Divider(),
                    ],
                  );
                }).toList(),
              ),
            )
          ],
        ),
      ),
    );
  }
}
