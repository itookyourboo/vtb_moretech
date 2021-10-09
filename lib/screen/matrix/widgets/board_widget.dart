import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:moretech_vtb/assets/vtb_ui_colors_dark.dart';
import 'package:moretech_vtb/screen/matrix/game/board.dart';
import 'package:moretech_vtb/screen/matrix/game/coordinate.dart';

class BoardWidget extends StatelessWidget {
  /// Creates an instance of [BoardWidget].
  const BoardWidget({
    required Key key,
    required this.selectedPositions,
    required this.board,
    required this.cellWidth,
    this.centeredCharacter = defaultCellProvider,
  }) : super(key: key);

  final List<Coordinate> selectedPositions;
  final Board board;
  final double cellWidth;
  final GridCharacterCellProvider centeredCharacter;

  @override
  Widget build(BuildContext context) {
    int width = board.width;

    return GridView.builder(
      shrinkWrap: true,
      itemCount: (width * width),
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: width,
        childAspectRatio: 1.0,
        crossAxisSpacing: 5.0,
        mainAxisSpacing: 5.0,
      ),
      itemBuilder: (context, index) {
        List<int> xy = _indexToXY(index, width);
        Coordinate position = Coordinate(xy[0], xy[1]);
        bool selected = selectedPositions.contains(position);
        String character = board[position];
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            border: Border.all(width: 5.0, color: blue60),
            color: (selected ? blue50 : Colors.white),
          ),
          child: centeredCharacter(
            cellWidth: cellWidth,
            selected: selected,
            character: character,
            position: position,
          ),
        );
      },
    );
  }

  static List<int> _indexToXY(int index, int width) {
    int y = (index / width).floor();
    int x = index - (y * width).floor();
    return [x, y];
  }
}

/// A provider for a widget used by [BoardWidget] to create its items.
typedef Widget GridCharacterCellProvider({
  required double cellWidth,
  required String character,
  required bool selected,
  required Coordinate position,
});

/// The default [GridCharacterCellProvider]
Widget defaultCellProvider({
  required double cellWidth,
  required String character,
  required bool selected,
  required Coordinate position,
}) =>
    _CenteredCharacter(cellWidth, character, selected);

class _CenteredCharacter extends StatelessWidget {
  _CenteredCharacter(
      this.cellWidth,
      this.character,
      this.selected,
      );

  final double cellWidth;
  final String character;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        character.toUpperCase(),
        style: TextStyle(
          fontSize: cellWidth / 4,
          fontWeight: FontWeight.bold,
          color: (selected ? Colors.white : Colors.black),
        ),
      ),
    );
  }
}