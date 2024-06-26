import 'dart:developer';

import 'package:tic_tac_toe/screens/game/ia_logic/ia_game.dart';

class GameLogic {
  List<List<int>> board = List.generate(3, (_) => List.filled(3, 0));
  GameIA ia = GameIA();

  void updateBoard(int index, int player) {
    board[index ~/ 3][index % 3] = player;
    log('Board updated by ${player == 1 ? 'player' : 'AI'}: $board');
  }

  bool isMovesLeft() {
    return ia.isMovesLeft(board);
  }

  Move findBestMove() {
    return ia.findBestMove(board);
  }

  bool isGameOver() {
    return ia.isGameOver(board);
  }

  bool isDraw() {
    log('Checking if it\'s a draw');
    // Check if no moves left and game is over
    if (!isMovesLeft() && isGameOver()) {
      log('It\'s a draw');
      return true;
    }
    return false;
  }
}
