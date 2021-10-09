import 'package:flutter/material.dart';
import 'package:moretech_vtb/assets/vtb_ui_typography.dart' as VtbTypography;
import 'package:moretech_vtb/hangman/screens/game_screen.dart';
import 'package:moretech_vtb/hangman/utilities/hangman_words.dart';

class GamesPage extends StatelessWidget {
  const GamesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    HangmanWords hangmanWords = HangmanWords();
    hangmanWords.readWords();

    return GridView.count(
        crossAxisCount: 2,
        children: [
          GameCard(text: 'Три в ряд', routeScreen: HangmanGameScreen(
              hangmanObject: HangmanWords()
          )),
          GameCard(text: 'Комбинатор', routeScreen: HangmanGameScreen(
              hangmanObject: HangmanWords()
          )),
          GameCard(text: 'Матрица', routeScreen: HangmanGameScreen(
              hangmanObject: HangmanWords()
          )),
          GameCard(text: 'Викторина', routeScreen: HangmanGameScreen(
              hangmanObject: HangmanWords()
          )),
          GameCard(
            text: 'Виселица',
            routeScreen: HangmanGameScreen(
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
                  child: Text(text, style: VtbTypography.headline)
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
