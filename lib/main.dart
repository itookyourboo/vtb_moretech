import 'package:flutter/material.dart';
import 'package:moretech_vtb/screen/games_page.dart';
import 'package:moretech_vtb/screen/intro_screen.dart';
import 'package:moretech_vtb/screen/main_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();

}

class _MyAppState extends State<MyApp> {
  static SharedPreferences? prefs;
  bool passed = false;

  @override
  void initState() {
    super.initState();
    initPreferences().whenComplete((){
      setState(() {
        passed = hasPassed();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Финансовая игротека',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: !passed ? IntroScreen((name, age){
        setState(() {
          passed = true;
          prefs!.setString("name", name);
          prefs!.setInt("age", age);
          prefs!.setBool("passed_intro", true);
        });
      }): const MainScreen(),
    );
  }

  Future<void> initPreferences() async {
    prefs = await SharedPreferences.getInstance();
  }

  bool hasPassed() {
    if (prefs != null) {
      return prefs!.containsKey("passed_intro");
    }
    return false;
  }
}
