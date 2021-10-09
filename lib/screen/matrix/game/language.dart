import 'dart:convert';

import 'dictionary.dart';
import 'game.dart';
import 'letter_sequence.dart';

class Language {
  Language._(this._frequencyInfo, this._dictionary);

  static LanguageLoader? _loader;
  static String? _currentCode;
  static Language? _currentLanguage;

  late LetterSequenceInfo _frequencyInfo;
  late Dictionary _dictionary;

  /// Registers the [LanguageLoader]
  static void registerLoader(LanguageLoader loader) => _loader = loader;

  /// Returns a Future instance of [Language] for the given language [code].
  static Future<Language> forLanguageCode(String code) async {
    if (_currentCode == code) {
      return _currentLanguage!;
    }
    return _load(code).then((language) {
      _currentCode = code;
      _currentLanguage = language;
      return language;
    });
  }

  static Future<Language> _load(String code) async {
    return Future.wait<String>([
      _loader!.characterSequenceFrequencies(code),
      _loader!.availableWords(code),
    ]).then((List<String> files) {
      return Language._(
        LetterSequenceInfo(_getFrequencies(files[0])),
        Dictionary(files[1].split("\n")..sort()),
      );
    }).then((Language language) {
      return language;
    });
  }

  static Map<String, int> _getFrequencies(String frequencies) {
    Map<String, int> result = {};
    Map<String, dynamic> m = json.decode(frequencies);
    m.forEach((k, dynamic e) => result[k] = e as int);
    return result;
  }

  /// Creates a new [Game]
  ///
  /// The new game uses the language dependent information contained by this
  /// class. The [boardWidth] determines the size of the [Board] to be created.
  /// The [minimalWordLength] determines the minimal size the words in the
  /// [Solution] will have.
  Game createGame(int boardWidth, int minimalWordLength) => Game(
    boardWidth,
    _frequencyInfo.createSequenceGenerator(),
    _dictionary,
    minimalWordLength,
  );
}

/// Container for dictionary related elements that need to be loaded
class LanguageLoader {
  /// Creates an instance of [LanguageLoader]
  LanguageLoader({
    required this.characterSequenceFrequencies,
    required this.availableWords,
  });

  /// Resolver for information about frequencies of character sequences
  Resolver characterSequenceFrequencies;

  /// All available words
  Resolver availableWords;
}

/// Returns a String for the given [languageCode]
typedef Future<String> Resolver(String languageCode);