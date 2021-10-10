import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:moretech_vtb/assets/vtb_ui_colors_dark.dart' as VtbColors;
import 'package:moretech_vtb/screen/games_page.dart';
import 'package:moretech_vtb/screen/profile_page.dart';
import 'package:moretech_vtb/screen/progress_page.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}): super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 1;
  static const List<Widget> _widgets = <Widget>[
    ProgressPage(),
    GamesPage(),
    ProfilePage()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Финансовая игротека'),
      ),
      body: Center(
        child: _widgets.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.assessment_outlined),
            label: 'Рейтинг',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.games),
            label: 'Игры',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Профиль',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: VtbColors.blue70,
        onTap: _onItemTapped,
      ),
    );
  }
}