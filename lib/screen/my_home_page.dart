import 'package:flutter/material.dart';
import 'package:moretech_vtb/assets/vtb_ui_typography.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: GridView.count(
        crossAxisCount: 2,
        children: const [
          GameCard(text: 'Три в ряд'),
          GameCard(text: 'Комбинатор'),
          GameCard(text: 'Матрица'),
          GameCard(text: 'Викторина'),
          GameCard(text: 'Виселица')
        ],
      ),
    );
  }
}

class GameCard extends StatelessWidget {
  final String text;

  const GameCard({Key? key, this.text = ''}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridTile(
        child: Card(
          child: InkWell(
              child: Center(
                  child: Text(text, style: headline)
              ),
              onTap: () {
                // Something happens
              },
          )
        )
    );
  }
}
