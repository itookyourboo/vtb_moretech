import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:moretech_vtb/assets/vtb_ui_colors_light.dart';
import 'package:moretech_vtb/assets/vtb_ui_typography.dart' as VtbTypography;
import 'dart:math';

import 'package:moretech_vtb/combinator/utilities/combinator_words.dart';

class CombinatorScreen extends StatefulWidget {
  const CombinatorScreen({required this.combinatorHelper});

  final CombinatorHelper combinatorHelper;

  @override
  State<CombinatorScreen> createState() => _CombinatorScreenState();
}

class _CombinatorScreenState extends State<CombinatorScreen> {
  late int totalFound = 0, totalAll = 0, finFound = 0, finAll = 0;
  late String word;
  late List<Letter> defaultLetters;
  late List<Letter> selectedLetters;
  late List<String> foundWords;
  late List<String> anagrams;
  late List<String> finAnagrams;

  @override
  void initState() {
    super.initState();
    word = widget.combinatorHelper.getRandomWord();
    print(word);
    anagrams = widget.combinatorHelper.getAnagrams(word);
    print(anagrams);
    totalAll = anagrams.length;
    finAnagrams = widget.combinatorHelper.getFinWords(anagrams);
    print(finAnagrams);
    finAll = finAnagrams.length;
    defaultLetters = List.generate(
        word.length, (index) => Letter(word[index], index, false));
    selectedLetters = [];
    foundWords = [];
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () {
          Navigator.pop(context);
          return Future(() => true);
        },
        child: Scaffold(
            body: Padding(
                padding:
                    EdgeInsets.only(top: 64, bottom: 12, left: 12, right: 12),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Text(
                          word,
                          style: VtbTypography.largeTitle1,
                          textAlign: TextAlign.center,
                        ),
                        Text('Слова: $totalFound/$totalAll',
                            style: VtbTypography.body1,
                            textAlign: TextAlign.center),
                        Text('Финансовые: $finFound/$finAll',
                            style: VtbTypography.body1.copyWith(color: blue60),
                            textAlign: TextAlign.center)
                      ],
                    ),
                    Container(
                        width: MediaQuery.of(context).size.width,
                        height: 160,
                        child: Wrap(
                          spacing: 8.0,
                          runSpacing: 4.0,
                          children: List.of(foundWords.map(
                              (e) => Text(e,
                                  style: finAnagrams.contains(e)?
                                  VtbTypography.caption1.copyWith(color: blue60):
                              VtbTypography.caption1))),
                        )),
                    Column(
                      children: [
                        Padding(
                            padding: EdgeInsets.only(top: 20),
                            child: Container(
                                height: 120,
                                alignment: Alignment.bottomCenter,
                                child: Row(
                                    children: List.of(selectedLetters.map(
                                        (letter) =>
                                            generateLetterCard(letter))),
                                    mainAxisAlignment:
                                        MainAxisAlignment.center))),
                        Row(
                          children: [
                            Container(
                                margin:
                                    const EdgeInsets.only(top: 8.0, right: 2.0),
                                width: MediaQuery.of(context).size.width / 3,
                                child: ElevatedButton(
                                    onPressed: () {
                                      setState(() {
                                        selectedLetters.clear();
                                        word
                                            .split('')
                                            .asMap()
                                            .forEach((index, element) {
                                          defaultLetters[index].letter =
                                              element;
                                        });
                                      });
                                    },
                                    child: const Text('Сброс'))),
                            Container(
                                margin:
                                    const EdgeInsets.only(top: 8.0, left: 2.0),
                                width: MediaQuery.of(context).size.width / 3,
                                child: ElevatedButton(
                                    onPressed: () {
                                      String input = selectedLetters
                                          .map((e) => e.letter)
                                          .join();
                                      if (anagrams.contains(input)) {
                                        setState(() {
                                          foundWords.add(input);
                                          totalFound++;
                                          if (finAnagrams.contains(input)) {
                                            finFound++;
                                          }
                                          selectedLetters.clear();
                                          word
                                              .split('')
                                              .asMap()
                                              .forEach((index, element) {
                                            defaultLetters[index].letter =
                                                element;
                                          });
                                        });
                                      } else {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(const SnackBar(
                                                content: Text(
                                                    'Извините, такого слова я не знаю.')));
                                      }
                                    },
                                    child: const Text('ОК')))
                          ],
                          mainAxisAlignment: MainAxisAlignment.center,
                        ),
                      ],
                    ),
                    Row(
                        children: List.of(defaultLetters
                            .map((letter) => generateLetterCard(letter))),
                        mainAxisAlignment: MainAxisAlignment.center),
                    Container(
                        margin: const EdgeInsets.only(top: 8.0),
                        width: MediaQuery.of(context).size.width,
                        child: ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text('Закончить игру')))
                  ],
                ))));
  }

  Card generateLetterCard(Letter letter) {
    return Card(
        child: InkWell(
            child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(letter.letter, style: VtbTypography.body1)),
            onTap: () {
              setState(() {
                if (letter.onLine) {
                  selectedLetters.remove(letter);
                  defaultLetters[letter.index].letter = letter.letter;
                } else {
                  if (defaultLetters[letter.index].letter == '_') return;
                  selectedLetters
                      .add(Letter(letter.letter, letter.index, true));
                  defaultLetters[letter.index].letter = '_';
                }
              });
            }));
  }
}

class Letter {
  String letter;
  int index;
  bool onLine;

  Letter(this.letter, this.index, this.onLine);
}
