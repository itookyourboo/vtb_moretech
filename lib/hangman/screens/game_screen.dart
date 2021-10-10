import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:moretech_vtb/assets/vtb_ui_colors_dark.dart';
import 'package:moretech_vtb/assets/vtb_ui_typography.dart';
import 'package:moretech_vtb/hangman/utilities/alphabet.dart';
import 'package:moretech_vtb/hangman/utilities/constants.dart';
import 'package:moretech_vtb/hangman/utilities/hangman_words.dart';
import 'package:moretech_vtb/screen/main_screen.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'dart:math';
import 'package:launch_review/launch_review.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:url_launcher/url_launcher.dart';

class HangmanGameScreen extends StatefulWidget {
  HangmanGameScreen({required this.hangmanObject});

  final HangmanWords hangmanObject;

  @override
  _HangmanGameScreenState createState() => _HangmanGameScreenState();
}

class _HangmanGameScreenState extends State<HangmanGameScreen> {
  int lives = 3;
  Alphabet russianAlphabet = Alphabet();
  late String word;
  late String meaning;
  late String hiddenWord;
  List<String> wordList = [];
  List<int> hintLetters = [];
  // final List<String> keywordsInvestments
  late List<bool> buttonStatus;
  late bool hintStatus;
  int hangState = 0;
  int wordCount = 0;
  bool finishedGame = false;
  bool resetGame = false;
  late SharedPreferences prefs;

  Future<void> logStart() async {
    await FirebaseAnalytics().logLevelStart(levelName: "game");
  }

  Future<void> logUpdate() async {
    await FirebaseAnalytics().logPostScore(score: wordCount, level: hangState, character: "game");
  }

  void newGame() {
    logStart();
    setState(() {
      widget.hangmanObject.resetWords();
      russianAlphabet = Alphabet();
      lives = 5;
      wordCount = 0;
      finishedGame = false;
      resetGame = false;
      initWords();
    });
  }

  Widget createButton(index) {
    ButtonStyle buttonStyle = ButtonStyle(
      overlayColor: MaterialStateProperty.all(blue100),
      shadowColor: MaterialStateProperty.all(blue100)
    );
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 3.5, vertical: 6.0),
      child: Center(
        child: TextButton(
          child: Text(russianAlphabet.alphabet[index].toUpperCase(),
              style: const TextStyle(
                color: Colors.white,
              ),
          ),
          style: buttonStyle,
          onPressed: (){
            wordPress(index);
          }
        ),
      ),
    );
  }

  void returnHomePage() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => MainScreen()),
      ModalRoute.withName('homePage'),
    );
  }

  void initWords() {
    finishedGame = false;
    resetGame = false;
    hintStatus = true;
    hangState = 0;
    buttonStatus = List.generate(33, (index) {
      return true;
    });
    wordList = [];
    hintLetters = [];
    word = widget.hangmanObject.getWord();
//    print
    print('this is word ' + word);
    if (word != '') {
      meaning = widget.hangmanObject.getMeaning();
    }
    // print(widget.hangmanObject.getMeaning(word));
    if (word.length != 0) {
      hiddenWord = widget.hangmanObject.getHiddenWord(word.length);
    } else {
      returnHomePage();
    }

    for (int i = 0; i < word.length; i++) {
      wordList.add(word[i]);
      hintLetters.add(i);
    }
  }

  void wordPress(int index) {
    // Crashlytics.instance.crash();
    logUpdate();
    if (buttonStatus[index] == false) return;

    if (lives == 0) {
      returnHomePage();
    }

    if (finishedGame) {
      setState(() {
        resetGame = true;
      });
      return;
    }

    bool check = false;
    setState(() {
      for (int i = 0; i < wordList.length; i++) {
        if (wordList[i] == russianAlphabet.alphabet[index]) {
          check = true;
          wordList[i] = '';
          hiddenWord = hiddenWord.replaceFirst(RegExp('_'), word[i], i);
        }
      }
      for (int i = 0; i < wordList.length; i++) {
        if (wordList[i] == '') {
          hintLetters.remove(i);
        }
      }
      if (!check) {
        hangState += 1;
      }

      if (hangState == 6) {
        finishedGame = true;
        lives -= 1;
        if (lives < 1) {
          Alert(
              style: GameOverAlertStyle,
              context: context,
              title: "Игра закончена!",
              desc: "Твой результат: $wordCount",
              buttons: [
                DialogButton(
//                  width: 20,
                  onPressed: () => returnHomePage(),
                  child: const Icon(
                    Icons.home,
                    color: Colors.white,
                    size: 30.0,
                  ),
//                  width: 90,
                  color: DialogButtonColor,
//                  height: 50,
                ),
                DialogButton(
//                  width: 20,
                  onPressed: () {
                    newGame();
                    Navigator.pop(context);
                  },
                  child: const Icon(Icons.refresh,color: Colors.white, size: 30.0),
//                  width: 90,
                  color: DialogButtonColor,
//                  height: 20,
                ),
              ]).show();
        } else {
          Alert(
            context: context,
            style: FailedAlertStyle,
            type: AlertType.error,
            title: word,
            desc: meaning,
            buttons: [
              DialogButton(
                radius: BorderRadius.circular(10),
                child: const Icon(
                  Icons.menu_book_outlined,
                  color: Colors.white,
                  size: 30.0,
                ),
                onPressed: () {
                  logVisitedLessons();
                  setState(() {
                    Navigator.pop(context);
                    initWords();
                  });
                  _launchURL();
                },
                width: 127,
                color: DialogButtonColor,
                height: 52,
              ),
              DialogButton(
                radius: BorderRadius.circular(10),
                child: const Icon(
                  Icons.arrow_forward_rounded,
                  color: Colors.white,
                  size: 30.0,
                ),
                onPressed: () {
                  setState(() {
                    Navigator.pop(context);
                    initWords();
                  });
                },
                width: 127,
                color: DialogButtonColor,
                height: 52,
              ),
            ],
          ).show();
        }
      }

      buttonStatus[index] = false;
      if (hiddenWord == word) {
        finishedGame = true;
        Alert(
          context: context,
          style: SuccessAlertStyle,
          type: AlertType.success,
          title: word,
          desc: meaning + " У тебя отлично получается, хочешь познакомиться с ВТБ поближе?",
          buttons: [
            DialogButton(
              radius: BorderRadius.circular(10),
              child: const Icon(
                Icons.account_balance_wallet_rounded,
                color: Colors.white,
                size: 30.0,
              ),
              onPressed: () {
                setState(() {
                  wordCount += 1;
                  Navigator.pop(context);
                  initWords();
                });
                launchInvestments();
              },
              width: 127,
              color: DialogButtonColor,
              height: 52,
            ),
            DialogButton(
              radius: BorderRadius.circular(10),
              child: const Icon(
                Icons.arrow_forward_rounded,
                color: Colors.white,
                size: 30.0,
              ),
              // child: const Icon(
              //   MdiIcons.arrowRightThick,
              //   color: Colors.white,
              //   size: 30.0,
              // ),
              onPressed: () {
                setState(() {
                  wordCount += 1;
                  updatePrefsProgress(1);
                  Navigator.pop(context);
                  initWords();
                });
              },
              width: 127,
              color: DialogButtonColor,
              height: 52,
            ),
          ],
        ).show();
      }
    });
  }

  @override
  void initState() {
    super.initState();
    initWords();
  }

  Future<void> logVisitedLessons() async {
    await FirebaseAnalytics().logEvent(name: "open_lessons");
  }

  @override
  Widget build(BuildContext context) {
    if (resetGame) {
      setState(() {
        initWords();
      });
    }
    return WillPopScope(
      onWillPop: () {
        Navigator.pop(context);
        return Future(() => true);
      },
      child: Scaffold(
        backgroundColor: blue40,
        body: SafeArea(
          child: Column(
            children: <Widget>[
              Expanded(
                  flex: 3,
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.fromLTRB(6.0, 8.0, 6.0, 35.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Stack(
                                  children: <Widget>[
                                    Container(
                                      padding: EdgeInsets.only(top: 0.5),
                                      child: IconButton(
                                        tooltip: 'Жизни',
                                        splashColor: Colors.white,
                                        iconSize: 39,
                                        icon: Icon(MdiIcons.heart, color: Colors.white),
                                        onPressed: () {},
                                      ),
                                    ),
                                    Container(
                                      padding:
                                          EdgeInsets.fromLTRB(8.7, 7.9, 0, 0.8),
                                      alignment: Alignment.center,
                                      child: SizedBox(
                                        height: 38,
                                        width: 38,
                                        child: Center(
                                          child: Padding(
                                            padding: const EdgeInsets.all(2.0),
                                            child: Text(
                                              lives.toString() == "1"
                                                  ? "I"
                                                  : lives.toString(),
                                              style: title2,
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                            Container(
                              child: Text(
                                wordCount == 1 ? "I" : '$wordCount',
                                style: WordCounterTextStyle,
                              ),
                            ),
                            Container(
                              child: IconButton(
                                tooltip: 'Подсказка',
                                iconSize: 39,
                                icon: Icon(MdiIcons.lightbulb, color: Colors.white),
                                splashColor: Colors.white,
                                onPressed: hintStatus
                                    ? () {
                                        int rand = Random()
                                            .nextInt(hintLetters.length);
                                        wordPress(russianAlphabet.alphabet
                                            .indexOf(
                                                wordList[hintLetters[rand]]));
                                        hintStatus = false;
                                      }
                                    : null,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 6,
                        child: Container(
                          alignment: Alignment.bottomCenter,
                          child: FittedBox(
                            child: Image.asset(
                              'assets/images/$hangState.png',
                              height: 1001,
                              width: 991,
                              gaplessPlayback: true,
                            ),
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 5,
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 35.0),
                          alignment: Alignment.center,
                          child: FittedBox(
                            fit: BoxFit.fitWidth,
                            child: Text(
                              hiddenWord,
                              style: kWordTextStyle,
                            ),
                          ),
                        ),
                      ),
                    ],
                  )),
              Container(
                padding: EdgeInsets.fromLTRB(10.0, 2.0, 8.0, 10.0),
                child: Table(
                  defaultVerticalAlignment: TableCellVerticalAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  //columnWidths: {1: FlexColumnWidth(10)},
                  children: [
                    TableRow(children: [
                      TableCell(
                        child: createButton(0),
                      ),
                      TableCell(
                        child: createButton(1),
                      ),
                      TableCell(
                        child: createButton(2),
                      ),
                      TableCell(
                        child: createButton(3),
                      ),
                      TableCell(
                        child: createButton(4),
                      ),
                      TableCell(
                        child: createButton(5),
                      ),
                      TableCell(
                        child: createButton(6),
                      ),
                    ]),
                    TableRow(children: [
                      TableCell(
                        child: createButton(7),
                      ),
                      TableCell(
                        child: createButton(8),
                      ),
                      TableCell(
                        child: createButton(9),
                      ),
                      TableCell(
                        child: createButton(10),
                      ),
                      TableCell(
                        child: createButton(11),
                      ),
                      TableCell(
                        child: createButton(12),
                      ),
                      TableCell(
                        child: createButton(13),
                      ),
                    ]),
                    TableRow(children: [
                      TableCell(
                        child: createButton(14),
                      ),
                      TableCell(
                        child: createButton(15),
                      ),
                      TableCell(
                        child: createButton(16),
                      ),
                      TableCell(
                        child: createButton(17),
                      ),
                      TableCell(
                        child: createButton(18),
                      ),
                      TableCell(
                        child: createButton(19),
                      ),
                      TableCell(
                        child: createButton(20),
                      ),
                    ]),
                    TableRow(children: [
                      TableCell(
                        child: createButton(21),
                      ),
                      TableCell(
                        child: createButton(22),
                      ),
                      TableCell(
                        child: createButton(23),
                      ),
                      TableCell(
                        child: createButton(24),
                      ),
                      TableCell(
                        child: createButton(25),
                      ),
                      TableCell(
                        child: createButton(26),
                      ),
                      TableCell(
                        child: createButton(27),
                      ),
                    ]),
                    TableRow(children: [
                      TableCell(
                        child: createButton(28),
                      ),
                      TableCell(
                        child: createButton(29),
                      ),
                      TableCell(
                        child: createButton(30),
                      ),
                      TableCell(
                        child: createButton(31),
                      ),
                      TableCell(
                        child: createButton(32),
                      ),
                      TableCell(
                        child: Text(''),
                      ),
                      TableCell(
                        child: Text(''),
                      ),
                    ]),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  Future<void> initPreferences() async {
    prefs = await SharedPreferences.getInstance();
  }
  _launchURL() async {
    await initPreferences();
    var url = 'https://school.vtb.ru/lessons/';
    if (prefs.getInt("age")! > 18) url = "https://school.vtb.ru/materials/courses/";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  void launchInvestments() async{
    await LaunchReview.launch(androidAppId: "ru.vtb.invest");
  }

  void updatePrefsProgress(int progress) {
    initPreferences();
    prefs.setInt("progress_v", prefs.getInt("progress_v") != null ? prefs.getInt("progress_v")! + progress : progress);
  }
}
