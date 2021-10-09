import 'package:flutter/cupertino.dart';
import 'preferences.dart';

import 'answer.dart';
import 'board.dart';

/// Information about an ongoing game
class GameInfo {
  /// Creates an instance of [GameInfo]
  GameInfo({
    required this.parameters,
    required this.board,
    required this.solution,
    required this.currentPlayer,
    required this.allUserAnswers,
  }) : randomWords = solution.uniqueWords().toList()..shuffle();

  /// The [GameParameters]
  final GameParameters parameters;

  /// The [Board]
  final Board board;

  /// The [Solution]
  final Solution solution;

  /// The number of the player who is currently playing
  int currentPlayer;

  /// A list of [ValueNotifier]s holding a [UserAnswer] for each player
  final List<ValueNotifier<UserAnswer>> allUserAnswers;

  /// A list all unique words contained by [Solution] in a random order
  final List<String> randomWords;

  /// Returns the user answer for the current player
  ValueNotifier<UserAnswer> get userAnswer => allUserAnswers[currentPlayer];

  /// Returns the the number of unique words the [solution] has.
  int availableWordsCount() => solution.uniqueWords().length;

  /// A convenience method to return the found and correct words by the current
  /// player.
  int currentPlayerFoundCount() => userAnswer.value.frequency.count;

  /// Returns the number of found and correct words for each player.
  List<int> playersFoundCount() =>
      allUserAnswers.map((a) => a.value.frequency.count).toList();

  /// Adds the listener for the element in [GameInfo.allUserAnswers] that has
  /// [currentPlayer] as the index.
  void addUserAnswerListener(VoidCallback listener) {
    allUserAnswers[currentPlayer].addListener(listener);
  }

  /// Removes the listener for the element in [GameInfo.allUserAnswers] that has
  /// [currentPlayer] as the index.
  void removeUserAnswerListener(VoidCallback listener) {
    allUserAnswers[currentPlayer].removeListener(listener);
  }
}
