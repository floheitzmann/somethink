import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:page_transition/page_transition.dart';
import 'package:somethink/models/questions_deck.dart';
import 'package:somethink/screens/game_screen.dart';
import 'package:somethink/screens/select_collection_of_questions.dart';
import 'package:somethink/screens/settings/settings_screen.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  QuestionDeck? _currentDeck;

  @override
  void initState() {
    FlutterNativeSplash.remove();
    super.initState();
  }

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
                    fullscreenDialog: true,
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
            _currentDeck == null
                ? Text(
                    S.of(context).notQuestionDeckSelectedTitle,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      // color: Colors.lightBlue,
                    ),
                    textAlign: TextAlign.center,
                  )
                : Column(
                    children: [
                      Text(
                        S.of(context).questionDeckSelectedTitle,
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        _currentDeck!.name,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          // color: Colors.lightBlue,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
            SizedBox(height: size.height * 0.015),
            TextButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SelectCollectionOfQuestions(
                    languageCode: locale.languageCode,
                  ),
                ),
              ).then((value) {
                setState(() {
                  if (value != null) {
                    _currentDeck = value;
                  }
                });
              }),
              style: TextButton.styleFrom(
                textStyle: const TextStyle(
                  fontSize: 16,
                ),
              ),
              child: Text(
                _currentDeck == null
                    ? S.of(context).choose
                    : S.of(context).change,
              ),
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
                onPressed: _currentDeck != null
                    ? () => Navigator.push(
                          context,
                          PageTransition(
                            child: GameScreen(
                              questions: _currentDeck!.questions,
                            ),
                            type: PageTransitionType.fade,
                          ),
                        )
                    : null,
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
