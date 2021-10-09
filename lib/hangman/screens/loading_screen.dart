import 'package:flutter/material.dart';
import 'package:moretech_vtb/hangman/screens/score_screen.dart';
import 'package:moretech_vtb/hangman/utilities/score_db.dart' as score_database;
import 'package:flutter_spinkit/flutter_spinkit.dart';

class HangmanLoadingScreen extends StatefulWidget {
  @override
  _HangmanLoadingScreenState createState() => _HangmanLoadingScreenState();
}

class _HangmanLoadingScreenState extends State<HangmanLoadingScreen> {
  @override
  void initState() {
    super.initState();
    queryScores();
  }

  void queryScores() async {
    final database = score_database.openDB();
    var queryResult = await score_database.scores(database);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) {
          return HangmanScoreScreen(
            query: queryResult,
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SpinKitDoubleBounce(
          color: Colors.white,
          size: 100.0,
        ),
      ),
    );
  }
}
