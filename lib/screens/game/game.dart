import 'dart:async';
import 'package:flutter/material.dart';
import 'package:tic_tac_toe/screens/game/custom_widgets/btn_creator.dart';
import 'package:tic_tac_toe/screens/game/custom_widgets/button.dart';
import 'package:tic_tac_toe/screens/game/custom_widgets/game_over_message.dart';
import 'package:tic_tac_toe/screens/game/custom_widgets/title_board.dart';
import 'package:tic_tac_toe/screens/game/ia_logic/game_logic.dart';
import 'package:tic_tac_toe/utils/figures.dart';
import 'package:tic_tac_toe/utils/winning_line_widget.dart';

import 'ia_logic/get_winning_line.dart';
import 'custom_widgets/animations/text_message_animation.dart';
import 'ia_logic/ia_game.dart';
import 'dart:math' as math;
import 'dart:developer';

enum Turn {
  userPlayer,
  iaPlayer,
}

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
  late Figure userFigure;
  late Figure iaFigure;
  late final ValueNotifier<WinningLine?> _winningLineNotifier =
      ValueNotifier<WinningLine?>(
          null); // ValueNotifier to notify the winning line

  late ValueNotifier<Turn> turn; // turn of the player
  late final ValueNotifier<int> _playerTurnsWon = ValueNotifier<int>(0);
  late final ValueNotifier<int> _iaTurnsWon = ValueNotifier<int>(0);
  late final notifierGameOver = ValueNotifier<bool>(false);
  bool isFirstGame = true;
  bool playerWinner = false;
  //handle the progress of the game
  final ValueNotifier<bool> isProgressRunning = ValueNotifier(false);
  @override
  void didChangeDependencies() {
    userFigure = ModalRoute.of(context)?.settings.arguments as Figure;
    iaFigure = userFigure == Figure.cross ? Figure.circle : Figure.cross;
    super.didChangeDependencies();
  }

  @override
  void initState() {
    if (isFirstGame) {
      turn = ValueNotifier<Turn>(isFirstGame && math.Random().nextInt(2) == 0
          ? Turn.userPlayer
          : Turn.iaPlayer);
    }
    Future.delayed(
      const Duration(milliseconds: 1500),
      () {
        if (isFirstGame) {
          decideTurn();
          isFirstGame = !isFirstGame;
        }
      },
    );
    // Listen time progress if it ends , TODO: fix interaction
    isProgressRunning.addListener(() {
      notifierGameOver.value = !isProgressRunning.value;
    });
    super.initState();
  }

  void decideTurn() {
    turn.value == Turn.iaPlayer ? iaTurn() : null;
  }

  void iaTurn() {
    if (gameLogic.isMovesLeft()) {
      Move bestMove = gameLogic.findBestMove();
      int aiIndex = bestMove.row * 3 + bestMove.col;
      aiMove(aiIndex);
    }
  }

  void endGame() {
    Navigator.pop(context);
  }

  void restartGame() {
    // Reset the game board
    gameLogic.board = List.generate(3, (_) => List.filled(3, 0));
    for (int i = 0; i < 9; i++) {
      _buttonNotifiers[i].value = Figure.empty;
    }
    _winningLineNotifier.value = null;
    notifierGameOver.value = false;
    isProgressRunning.value = true;
    if (playerWinner) {
      turn.value = Turn.iaPlayer;
      iaTurn();
    } else {
      turn.value = Turn.userPlayer;
    }
  }

  void updateBoard(int index, int player) {
    // Update the game board
    gameLogic.board[index ~/ 3][index % 3] = player;
    log('Board updated by ${player == 1 ? 'player' : 'AI'}: $gameLogic.board');
  }

  void playerMove(int index) {
    log('playerMove called. index: $index');
    gameLogic.updateBoard(index, 1);
    _buttonNotifiers[index].value = userFigure;

    if (gameLogic.isGameOver()) {
      log('Player Win');
      WinningLine? winningLine = getWinningLine(gameLogic.board);
      if (winningLine != null) {
        log('Winning line starts at ${winningLine.start} and ends at ${winningLine.end}');
        Future.delayed(const Duration(milliseconds: 500), () {
          _winningLineNotifier.value = winningLine;
          _playerTurnsWon.value++;
        });
        Future.delayed(const Duration(milliseconds: 1000), () {
          notifierGameOver.value = true;
        });
        playerWinner = true;
      }
    } else if (gameLogic.isMovesLeft()) {
      Move bestMove = gameLogic.findBestMove();
      int aiIndex = bestMove.row * 3 + bestMove.col;
      aiMove(aiIndex);
    }
  }

  void aiMove(int index) {
    if (gameLogic.board[index ~/ 3][index % 3] == 0) {
      gameLogic.updateBoard(index, -1);
      Future.delayed(const Duration(milliseconds: 500), () {
        _buttonNotifiers[index].value = iaFigure;
      });
    }
    if (gameLogic.isGameOver()) {
      log('Ia Win');
      WinningLine? winningLine = getWinningLine(gameLogic.board);
      if (winningLine != null) {
        log('Winning line starts at ${winningLine.start} and ends at ${winningLine.end}');
        Future.delayed(const Duration(milliseconds: 1200), () {
          _winningLineNotifier.value = winningLine;
          _iaTurnsWon.value++;
        });
        Future.delayed(const Duration(milliseconds: 1000), () {
          notifierGameOver.value = true;
        });
        playerWinner = false;
      }
    }
  }

  IgnorePointer buildWinnerLine(double width, double height) {
    return IgnorePointer(
      child: ValueListenableBuilder<WinningLine?>(
        valueListenable: _winningLineNotifier,
        builder: (context, winningLine, child) {
          if (winningLine != null) {
            return WinningLineWidget(
              start: winningLine.start,
              end: winningLine.end,
              size: Size(width, height / 2),
            );
          } else {
            return Container(); // return an empty container when there's no winning line
          }
        },
      ),
    );
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
              TitleBoard(
                width: width,
                height: height,
                playerTurnsWon: _playerTurnsWon,
                iaTurnsWon: _iaTurnsWon,
                isProgressRunning: isProgressRunning,
              ),
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
                      return ValueListenableBuilder(
                          valueListenable: isProgressRunning,
                          builder: (context, isRunning, _) {
                            return IgnorePointer(
                              ignoring:
                                  !isRunning, //ignore if the progress is not running
                              child: BtnCreator(
                                key: buttonKeys[index],
                                width: width,
                                height: height,
                                index: index,
                                figureNotifier: _buttonNotifiers[index],
                                onPress: () {
                                  // Check if the game is not over before making a player user move
                                  if (!gameLogic.isGameOver()) {
                                    playerMove(index);
                                    //log(gameLogic.board.toString());
                                  }
                                },
                              ),
                            );
                          });
                    },
                  ),
                  buildWinnerLine(width, height),
                  Positioned(
                    left: width * 0.10,
                    top: height * 0.01,
                    child: ValueListenableBuilder(
                      valueListenable: turn,
                      builder: (context, Turn value, _) {
                        return value == Turn.userPlayer
                            ? const TextMessage(
                                key: Key('userTurn'),
                                message: '!Your turn!',
                                fontSize: 45,
                              )
                            : const TextMessage(
                                key: Key('iaTurn'),
                                message: '!The game is started!',
                                fontSize: 25,
                              );
                      },
                    ),
                  ),
                  ValueListenableBuilder(
                    valueListenable: notifierGameOver,
                    builder: (context, gameOver, _) => gameOver
                        ? GameOverMessage(
                            //add emoji to the message
                            message: playerWinner
                                ? '¡You Win! 🏆'
                                : '¡You Loose! 😞',
                          )
                        : Container(),
                  ),
                ],
              ),
              SizedBox(
                height: height / 20,
              ),
              Button(
                fontColor: Colors.white,
                backgroundColor: Colors.transparent,
                borderColor: Colors.white,
                text: 'Restart',
                onPressed: () {
                  restartGame();
                },
              ),
              SizedBox(
                height: height / 50,
              ),
              Button(
                fontColor: Colors.white,
                backgroundColor: Colors.transparent,
                borderColor: Colors.white,
                text: 'End game',
                onPressed: () {
                  endGame();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
