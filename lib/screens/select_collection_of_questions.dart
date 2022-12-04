import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:somethink/app.dart';
import 'package:somethink/models/questions_deck.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SelectCollectionOfQuestions extends StatefulWidget {
  const SelectCollectionOfQuestions({
    super.key,
    required this.languageCode,
  });

  final String languageCode;

  @override
  State<SelectCollectionOfQuestions> createState() =>
      _SelectCollectionOfQuestionsState();
}

class _SelectCollectionOfQuestionsState
    extends State<SelectCollectionOfQuestions> {
  List<QuestionDeck> decks = [];
  QuestionDeck? _selectedDeck;

  @override
  void initState() {
    loadCollections().then((value) {
      setState(() {
        decks = value;
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
        title: Text(S.of(context).decks(decks.length)),
        titleTextStyle: Theme.of(context).textTheme.headline5,
        actions: [
          if (_selectedDeck != null)
            IconButton(
              onPressed: () {
                Navigator.pop(
                  context,
                  _selectedDeck,
                );
              },
              icon: IconTheme(
                data: Theme.of(context).iconTheme,
                child: const Icon(
                  Icons.check,
                ),
              ),
            ),
        ],
      ),
      body: SafeArea(
        minimum: const EdgeInsets.symmetric(vertical: 8.0),
        child: ListView.builder(
          physics: const ScrollPhysics(),
          itemCount: decks.length,
          itemBuilder: (context, index) {
            return createSelectableQuestionDeck(decks[index]);
          },
        ),
      ),
    );
  }

  Widget createSelectableQuestionDeck(QuestionDeck deck) {
    return ListTile(
      title: Text(deck.name),
      selected: _selectedDeck != null && _selectedDeck == deck,
      subtitle: Text(deck.description),
      onTap: () {
        setState(() {
          if (_selectedDeck != null && _selectedDeck == deck) {
            _selectedDeck = null;
          } else {
            _selectedDeck = deck;
          }
        });
      },
    );
  }

  Future<List<QuestionDeck>> loadCollections() async {
    List<QuestionDeck> list = [];

    for (var key in collectionNames) {
      var string = await rootBundle.loadString("assets/$key.json");
      var allData = jsonDecode(string);
      var data = allData[widget.languageCode];
      var deck = QuestionDeck(
        widget.languageCode,
        data["name"],
        data["description"],
        data["questions"].cast<String>(),
      );

      list.add(deck);
    }

    return list;
  }
}
