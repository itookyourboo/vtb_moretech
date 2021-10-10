import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:moretech_vtb/assets/vtb_ui_colors_light.dart';
import 'package:moretech_vtb/assets/vtb_ui_typography.dart' as VtbTypography;
import 'package:moretech_vtb/combinator/screens/game_screen.dart';
import 'package:moretech_vtb/combinator/utilities/combinator_words.dart';
import 'package:moretech_vtb/hangman/screens/game_screen.dart';
import 'package:moretech_vtb/hangman/utilities/hangman_words.dart';

class GamesPage extends StatelessWidget {
  const GamesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    HangmanWords hangmanWords = HangmanWords();
    hangmanWords.readWords();
    CombinatorHelper combinatorHelper = CombinatorHelper();
    combinatorHelper.readWords();

    return GridView.count(crossAxisCount: 2, children: [
      GameCard(
          text: 'Виселица',
          routeScreen: HangmanGameScreen(hangmanObject: hangmanWords)),
      GameCard(
          text: 'Комбинатор',
          routeScreen: CombinatorScreen(combinatorHelper: combinatorHelper)),
      GameCard(
          text: 'Три в ряд',
          routeScreen: HangmanGameScreen(hangmanObject: hangmanWords),
          disable: true),
      GameCard(
          text: 'Матрица',
          routeScreen: HangmanGameScreen(hangmanObject: hangmanWords),
          disable: true),
      GameCard(
          text: 'Викторина',
          routeScreen: HangmanGameScreen(hangmanObject: hangmanWords),
          disable: true)
    ]);
  }
}

class GameCard extends StatelessWidget {
  final String text;
  final Widget routeScreen;
  final bool disable;

  const GameCard(
      {Key? key,
      this.text = '',
      this.routeScreen = const GamesPage(),
      this.disable = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridTile(
        child: Card(
            child: InkWell(
      child: Center(
          child: Text(text,
              style: disable
                  ? VtbTypography.headline.copyWith(color: blue20)
                  : VtbTypography.headline.copyWith(color: blue70))),
      onTap: () {
        if (!disable) {
          logOpenGame(text);
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => routeScreen));
        }
      },
    )));
  }

  Future<void> logOpenGame(String game) async {
    await FirebaseAnalytics().logLevelStart(levelName: game);
  }
}
