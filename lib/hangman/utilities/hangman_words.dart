import 'dart:convert';
import 'dart:math';
import 'package:flutter/services.dart' show rootBundle;

class HangmanWords {
  int wordCounter = 0;
  int wordNum = 0;
  List<int> _usedNumbers = [];
  List<String> _words = [];
  List<String> _meanings = [];

  Future readWords() async {
    String fileText = await rootBundle.loadString('res/hangman_words.txt');
    _words = fileText.split('\n').map((e) => e.trim()).toList();
    String fileText2 = await rootBundle.loadString('res/hangman_meanings.txt');
    _meanings = fileText2.split('\n');
  }

  void resetWords() {
    wordCounter = 0;
    _usedNumbers = [];
//    _words = [];
  }

  // ignore: missing_return
  String getWord() {
    wordCounter += 1;
    var rand = Random();
    int wordLength = _words.length;
    int randNumber = 1 + rand.nextInt(wordLength - 1);
    wordNum = randNumber;
    bool notUnique = true;
    if (wordCounter - 1 == _words.length) {
      notUnique = false;
      return '';
    }
    while (notUnique) {
      if (!_usedNumbers.contains(randNumber)) {
        notUnique = false;
        _usedNumbers.add(randNumber);
        return _words[randNumber];
      } else {
        randNumber = rand.nextInt(wordLength);
      }
    }
    return '';
  }

  String getMeaning() {
    return _meanings[wordNum];
  }

  String getHiddenWord(int wordLength) {
    String hiddenWord = '';
    for (int i = 0; i < wordLength; i++) {
      hiddenWord += '_';
    }
    return hiddenWord;
  }
}
