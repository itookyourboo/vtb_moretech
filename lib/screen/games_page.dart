import 'package:flutter/material.dart';
import 'package:moretech_vtb/assets/vtb_ui_typography.dart';
import 'package:moretech_vtb/screen/flutter_hangman/screens/game_screen.dart';
import 'package:moretech_vtb/screen/flutter_hangman/screens/home_screen.dart';

import 'flutter_hangman/utilities/hangman_words.dart';

class GamesPage extends StatelessWidget {
  const GamesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    HangmanWords hangmanWords = HangmanWords();
    hangmanWords.readWords();

    return GridView.count(
        crossAxisCount: 2,
        children: [
          GameCard(text: 'Три в ряд', routeScreen: GameScreen(
              hangmanObject: HangmanWords()
          )),
          GameCard(text: 'Комбинатор', routeScreen: GameScreen(
              hangmanObject: HangmanWords()
          )),
          GameCard(text: 'Матрица', routeScreen: GameScreen(
              hangmanObject: HangmanWords()
          )),
          GameCard(text: 'Викторина', routeScreen: GameScreen(
              hangmanObject: HangmanWords()
          )),
          GameCard(
            text: 'Виселица',
            routeScreen: GameScreen(
              hangmanObject: hangmanWords
            )
          )
        ]
    );
  }
}

class GameCard extends StatelessWidget {
  final String text;
  final Widget routeScreen;

  const GameCard({Key? key, this.text = '', this.routeScreen = const GamesPage()}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridTile(
        child: Card(
          child: InkWell(
              child: Center(
                  child: Text(text, style: headline)
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => routeScreen)
                );
              },
          )
        )
    );
  }
}
