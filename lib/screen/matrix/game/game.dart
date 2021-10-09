import 'answer.dart';
import 'board.dart';
import 'dictionary.dart';
import 'letter_sequence.dart';

class Game {
  /// Creates a [Board] and a [Solution] to be contained by the new game.
  ///
  /// The new board has width [boardWidth] and is filled with letters generated
  /// by the [generator]. The solution is then created based on the given
  /// [dictionary] and [minimalWordLength].
  ///
  /// It is guaranteed that the generated board has a solution that contains at
  /// least one word.
  factory Game(
      int boardWidth,
      SequenceGenerator generator,
      Dictionary dictionary,
      int minimalWordLength,
      ) {
    Board board = Board(
      width: boardWidth,
      generator: generator,
      word: dictionary.randomWord(5),
    );

    Solution solution = Solution(
      board,
      dictionary,
      minimalWordLength,
    );

    return Game._(board, solution);
  }

  Game._(this.board, this.solution);

  /// The [Board]
  final Board board;

  /// The [Solution]
  final Solution solution;
}