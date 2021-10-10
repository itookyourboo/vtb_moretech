import 'dart:convert';
import 'dart:math';
import 'package:flutter/services.dart' show rootBundle;

class CombinatorHelper {
  List<String> allWords = [];
  List<String> finWords = [];
  List<String> randWords = [];

  Future readWords() async {
    List<String> types = (await rootBundle.loadString('res/combinator_words.txt')).toUpperCase().split('=');
    allWords = types[0].split('\n').map((e) => e.trim()).toList();
    allWords.removeLast();
    finWords = types[1].split('\n').map((e) => e.trim()).toList();
    allWords.removeLast();
    randWords = types[2].split('\n').map((e) => e.trim()).toList();
    allWords.removeLast();

    print('combinator loaded');
  }

  List<String> getAnagrams(String original) {
    return allWords.where((word) => isConsist(original, word)).toList();
  }

  List<String> getFinWords(List<String> consistWords) {
    return consistWords.where(isFin).toList();
  }

  bool isConsist(String original, String word) {
    if (original == word) return false;

    for (String letter in word.split('')) {
      if (count(word, letter) > count(original, letter)) {
        return false;
      }
    }
    return true;
  }

  String getRandomWord() {
    return randWords[Random().nextInt(randWords.length)];
  }

  int count(String word, String letter) {
    return RegExp(letter).allMatches(word).length;
  }

  bool isFin(String word) {
    return finWords.contains(word);
  }
}

