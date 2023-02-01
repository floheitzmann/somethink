import 'dart:io';

import 'package:flutter/material.dart';
import 'package:somethink/app.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:somethink/screens/help_screen.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key, required this.questions});

  final List<String> questions;

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  List<String> history = [];
  int _index = 0;

  @override
  void initState() {
    widget.questions.shuffle();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if ((_index + 1) < widget.questions.length) {
          setState(() {
            _index++;
          });
        }
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(
              Icons.close,
              size: 30,
              color: Colors.black,
            ),
          ),
          title: Text(
            "${_index + 1}/${widget.questions.length}",
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w600,
            ),
          ),
          actions: [
            IconButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => HelpScreen(),
                ),
              ),
              icon: const Icon(
                Icons.help_outline,
                size: 30,
                color: Colors.black,
              ),
            ),
          ],
        ),
        backgroundColor: colors[backgroundColorKey],
        body: GestureDetector(
          child: SafeArea(
            minimum: const EdgeInsets.symmetric(horizontal: 16.0),
            child: GestureDetector(
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      widget.questions[_index],
                      style: const TextStyle(
                        fontWeight: FontWeight.w800,
                        color: Colors.black,
                        fontSize: 32,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    if (_index >= 1) const SizedBox(height: 20),
                    if (_index >= 1)
                      createRoundedTextButton(
                        S.of(context).lastQuestion,
                        () {
                          if (_index > 0) {
                            setState(() {
                              _index--;
                            });
                          }
                        },
                      ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget createRoundedTextButton(String text, Function() func) {
    return InkWell(
      borderRadius: BorderRadius.circular(99),
      onTap: func,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.black,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(99),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 8,
          ),
          child: Text(
            text,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}
