import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:moretech_vtb/hangman/components/action_button.dart';
import 'package:moretech_vtb/hangman/utilities/hangman_words.dart';
import 'game_screen.dart';
import 'loading_screen.dart';

class HangmanHomeScreen extends StatefulWidget {
  final HangmanWords hangmanWords = HangmanWords();

  @override
  _HangmanHomeScreenState createState() => _HangmanHomeScreenState();
}

class _HangmanHomeScreenState extends State<HangmanHomeScreen> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    widget.hangmanWords.readWords();
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: <Widget>[
          Center(
            child: Container(
              margin: EdgeInsets.fromLTRB(8.0, 1.0, 8.0, 8.0),
              child: const Text(
                'ВИСЕЛИЦА',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 58.0,
                    fontWeight: FontWeight.w300,
                    letterSpacing: 3.0),
              ),
            ),
          ),
          Center(
            child: Container(
//              padding: EdgeInsets.all(5.0),
              child: Image.asset(
                'images/gallow.png',
                height: height * 0.49,
              ),
            ),
          ),
          SizedBox(
            height: 15.0,
          ),
          Center(
            child: IntrinsicWidth(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Container(
//                    width: 155,
                    height: 64,
                    child: ActionButton(
                      buttonTitle: 'Начать',
                      onPress: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HangmanGameScreen(
                              hangmanObject: widget.hangmanWords,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(
                    height: 18.0,
                  ),
                  Container(
//                    width: 155,
                    height: 64,
                    child: ActionButton(
                      buttonTitle: 'Рекорды',
                      onPress: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HangmanLoadingScreen(),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      )),
    );
  }
}
