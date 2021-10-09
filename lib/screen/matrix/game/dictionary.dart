import 'package:collection/collection.dart';

class Dictionary {
  /// Creates a dictionary with the given [words].
  Dictionary(this._words);

  final List<String> _words;

  /// Looks up [word] in this dictionary and returns information about it.
  WordInfo getInfo(String word) {
    int index = lowerBound(_words, word);

    if (index == _words.length) return _notFoundDeadEnd;

    String higher = _words[index];
    if (higher == word) return _found;
    if (higher.startsWith(word)) return _notFoundCanStart;
    return _notFoundDeadEnd;
  }

  /// Returns a random word with the given [length]. If the dictionary does not
  /// contain a word with the given length an [ArgumentError] will be thrown.
  String randomWord(int length) =>
      (_words.where((w) => w.length == length).toList()..shuffle()).firstWhere(
              (w) => true,
          orElse: () => throw ArgumentError('no word for length $length'));
}

/// Information about a word
class WordInfo {
  const WordInfo._(this.found, this.canStartWith);

  /// [true] if this word is in the [Dictionary], [false] otherwise.
  final bool found;

  /// [true] if there is at least one word in the [Dictionary] that starts with
  /// the word, [false] otherwise. If [found] is [true], [canStartWith] is also
  /// [true].
  final bool canStartWith;
}

const WordInfo _notFoundDeadEnd = WordInfo._(false, false);
const WordInfo _notFoundCanStart = WordInfo._(false, true);
const WordInfo _found = WordInfo._(true, true);