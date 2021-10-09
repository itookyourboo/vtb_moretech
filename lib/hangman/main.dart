import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:moretech_vtb/assets/vtb_ui_colors_dark.dart';
import 'package:moretech_vtb/hangman/screens/home_screen.dart';
import 'package:moretech_vtb/hangman/utilities/constants.dart';
import 'package:moretech_vtb/hangman/screens/score_screen.dart';

void main() {
  return runApp(HangmanApp());
}

class HangmanApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        tooltipTheme: TooltipThemeData(
          decoration: BoxDecoration(
            color: kTooltipColor,
            borderRadius: BorderRadius.circular(5.0),
          ),
          textStyle: TextStyle(
            fontWeight: FontWeight.w900,
            fontSize: 20.0,
            letterSpacing: 1.0,
            color: Colors.white,
          ),
        ),
        scaffoldBackgroundColor: blue30,
        textTheme: Theme.of(context).textTheme.apply(fontFamily: 'PatrickHand'),
      ),
      initialRoute: 'homePage',
      routes: {
        'homePage': (context) => HangmanHomeScreen(),
        'scorePage': (context) => HangmanScoreScreen(),
      },
    );
  }
}
