import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HelpScreen extends StatelessWidget {
  HelpScreen({super.key});

  final _url = Uri.parse("https://discord.gg/VCr3hacctM");

  @override
  Widget build(BuildContext context) {
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
                  child: const Icon(
                    CupertinoIcons.arrow_left,
                  ),
                ),
              ),
        title: Text(S.of(context).helpCenterTitle),
        titleTextStyle: Theme.of(context).textTheme.headline5,
      ),
      body: SafeArea(
        minimum: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              S.of(context).helpCenterMessage,
              textAlign: TextAlign.justify,
            ),
            const SizedBox(height: 6),
            GestureDetector(
              onTap: _launchUrl,
              child: const Text(
                "https://discord.gg/VCr3hacctM",
                style: TextStyle(
                  color: Colors.blue,
                ),
              ),
            ),
            const SizedBox(height: 12),
            Text(
              S.of(context).helpCenterSubMessage,
              textAlign: TextAlign.justify,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _launchUrl() async {
    if (!await launchUrl(_url)) {
      throw "Could not launch $_url";
    }
  }
}
