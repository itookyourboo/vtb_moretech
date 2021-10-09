// Button to start the game with
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:moretech_vtb/screen/matrix/game/answer.dart';
import 'package:moretech_vtb/screen/matrix/game/game.dart';
import 'package:moretech_vtb/screen/matrix/game/game_info.dart';
import 'package:moretech_vtb/screen/matrix/game/language.dart';
import 'package:moretech_vtb/screen/matrix/game/preferences.dart';
import 'package:moretech_vtb/screen/matrix/screens/game_screen.dart';

class StartGameButton extends StatefulWidget {
  StartGameButton({
    required Key key,
    required this.parameterProvider,
    required this.replaceScreen,
  }) : super(key: key);

  final ParameterProvider parameterProvider;
  final bool replaceScreen;

  @override
  State<StatefulWidget> createState() => _StartGameButtonState();
}

class _StartGameButtonState extends State<StartGameButton> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 50,
      child: isLoading
          ? const CircularProgressIndicator()
          : FloatingActionButton(
        heroTag: 'playgame',
        onPressed: _pressPlayButton(context),
        child: Icon(Icons.play_arrow),
      ),
    );
  }

  VoidCallback _pressPlayButton(BuildContext context) => () {
    setState(() {
      isLoading = true;
    });

    GameParameters parameters = widget.parameterProvider();
    Language.forLanguageCode(parameters.languageCode).then((language) {
      Game game = language.createGame(
        parameters.boardWidth,
        parameters.minimalWordLength,
      );

      GameInfo gameInfo = GameInfo(
        parameters: parameters,
        currentPlayer: 0,
        board: game.board,
        solution: game.solution,
        allUserAnswers: List.generate(
          parameters.numberOfPlayers,
              (_) => ValueNotifier(UserAnswer.start()),
        ),
      );

      Widget screenBuilder(BuildContext context) {
        return parameters.numberOfPlayers > 1
            ? PlayerScreen(
          gameInfo: gameInfo,
        )
            : GameScreen(
          gameInfo: gameInfo,
        );
      }

      if (widget.replaceScreen) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute<Null>(
            builder: screenBuilder,
          ),
        );
      } else {
        Navigator.push(
          context,
          MaterialPageRoute<Null>(
            builder: screenBuilder,
          ),
        ).then((value) {
          setState(() {
            isLoading = false;
          });
        });
      }
    });
  };
}