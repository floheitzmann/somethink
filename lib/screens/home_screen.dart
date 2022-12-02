import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:somethink/screens/game_screen.dart';
import 'package:somethink/screens/settings/settings_screen.dart';
import 'package:flutter/services.dart' show rootBundle;

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final locale = Localizations.localeOf(context);

    return Scaffold(
      body: SafeArea(
        minimum: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: IconButton(
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SettingsScreen(),
                  ),
                ),
                icon: IconTheme(
                  data: Theme.of(context).iconTheme,
                  child: const Icon(
                    Icons.settings,
                    size: 30,
                  ),
                ),
              ),
            ),
            const Spacer(),
            IconTheme(
              data: Theme.of(context).iconTheme,
              child: const Icon(Icons.spatial_tracking_outlined, size: 200),
            ),
            const Spacer(),
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  shadowColor: Colors.transparent,
                  backgroundColor: Colors.deepOrange,
                  minimumSize: Size(size.width * 0.7, 60),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                    side: BorderSide.none,
                  ),
                ),
                onPressed: () async {
                  var questions = json.decode(
                    await rootBundle
                        .loadString('assets/questions_for_friends.json'),
                  );

                  var list = questions[locale.languageCode].cast<String>();

                  Navigator.push(
                    context,
                    PageTransition(
                      child: GameScreen(
                        questions: list,
                      ),
                      type: PageTransitionType.fade,
                    ),
                  );
                },
                child: Text(
                  S.of(context).play,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SizedBox(height: size.height * 0.025),
          ],
        ),
      ),
    );
  }
}
