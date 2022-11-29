import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../app.dart';
import '../../theme/theme_provider.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ChangeGameBackgroundScreen extends StatefulWidget {
  const ChangeGameBackgroundScreen({super.key});

  @override
  State<ChangeGameBackgroundScreen> createState() =>
      _ChangeGameBackgroundScreenState();
}

class _ChangeGameBackgroundScreenState
    extends State<ChangeGameBackgroundScreen> {
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
        title: Text(S.of(context).gameBackgroundTitle),
        titleTextStyle: Theme.of(context).textTheme.headline5,
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
                    ? Colors.grey.shade900
                    : Colors.grey.shade50,
                borderRadius: BorderRadius.circular(8),
              ),
              width: double.infinity,
              child: Wrap(
                spacing: 10,
                children: colors.entries
                    .map(
                      (entry) => InkWell(
                        onTap: () {
                          setState(() {
                            backgroundColorKey = entry.key;
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
