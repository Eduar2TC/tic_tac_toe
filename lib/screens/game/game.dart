import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:tic_tac_toe/screens/game/custom_widgets/btn_creator.dart';
import 'package:tic_tac_toe/screens/game/custom_widgets/button.dart';
import 'package:tic_tac_toe/screens/game/custom_widgets/title_board.dart';
import 'package:tic_tac_toe/screens/game/ia_logic/game_logic.dart';
import 'package:tic_tac_toe/utils/element_drawer.dart';
import 'package:tic_tac_toe/utils/winning_line_painter.dart';

import 'ia_logic/ia_game.dart';

class Game extends StatefulWidget {
  const Game({super.key});

  @override
  State<Game> createState() => _GameState();
}

class _GameState extends State<Game> {
  final Map<int, GlobalKey<BtnCreatorState>> buttonKeys = {};
  final List<ValueNotifier<Figure>> _buttonNotifiers =
      List.generate(9, (_) => ValueNotifier(Figure.empty));
  final GameLogic gameLogic = GameLogic();

  void updateBoard(int index, int player) {
    // Update the game board
    gameLogic.board[index ~/ 3][index % 3] = player;
    log('Board updated by ${player == 1 ? 'player' : 'AI'}: $gameLogic.board');
  }

  void playerMove(int index) {
    log('playerMove called. index: $index');
    gameLogic.updateBoard(index, 1);
    _buttonNotifiers[index].value = Figure.cross;
    if (gameLogic.isMovesLeft()) {
      Move bestMove = gameLogic.findBestMove();
      int aiIndex = bestMove.row * 3 + bestMove.col;
      aiMove(aiIndex);
    }
  }

  void aiMove(int index) {
    if (gameLogic.board[index ~/ 3][index % 3] == 0) {
      gameLogic.updateBoard(index, -1);
      Future.delayed(const Duration(milliseconds: 500), () {
        setState(() {
          _buttonNotifiers[index].value = Figure.circle;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    //make grid of buttons
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: <Color>[
              Colors.deepPurpleAccent,
              Colors.deepPurple,
              Colors.deepPurple.shade900,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TitleBoard(width: width, height: height),
              Stack(
                alignment: Alignment.center,
                children: [
                  GridView.builder(
                    shrinkWrap: true,
                    itemCount: 9,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                    ),
                    itemBuilder: (BuildContext context, int index) {
                      buttonKeys[index] = GlobalKey<BtnCreatorState>();
                      //element of grid
                      return BtnCreator(
                        key: buttonKeys[index],
                        width: width,
                        height: height,
                        index: index,
                        figureNotifier: _buttonNotifiers[index],
                        onPress: () {
                          playerMove(index);
                          log(gameLogic.board.toString());
                        },
                      );
                    },
                  ),
                  IgnorePointer(
                    child: CustomPaint(
                      size: Size(width, height / 2),
                      painter: WinningLinePainter(start: 1, end: 7),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: height / 20,
              ),
              const Button(
                fontColor: Colors.white,
                backgroundColor: Colors.transparent,
                borderColor: Colors.white,
                text: 'Restart',
              ),
              SizedBox(
                height: height / 50,
              ),
              const Button(
                fontColor: Colors.deepPurple,
                backgroundColor: Colors.white,
                borderColor: Colors.white,
                text: 'End game',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
