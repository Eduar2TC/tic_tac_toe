import 'dart:math';

class GameIA {
  static const int PLAYER = 1;
  static const int AI = -1;
  static const int EMPTY = 0;

  List<List<int>> board = List.generate(3, (_) => List.filled(3, EMPTY));

  bool isMovesLeft(List<List<int>> board) {
    for (int i = 0; i < 3; i++) {
      for (int j = 0; j < 3; j++) {
        if (board[i][j] == EMPTY) {
          return true;
        }
      }
    }
    return false;
  }

  int evaluate(List<List<int>> b) {
    // Checking for Rows for X or O victory.
    for (int row = 0; row < 3; row++) {
      if (b[row][0] == b[row][1] && b[row][1] == b[row][2]) {
        if (b[row][0] == PLAYER) {
          return 10;
        } else if (b[row][0] == AI) {
          return -10;
        }
      }
    }

    // Checking for Columns for X or O victory.
    for (int col = 0; col < 3; col++) {
      if (b[0][col] == b[1][col] && b[1][col] == b[2][col]) {
        if (b[0][col] == PLAYER) {
          return 10;
        } else if (b[0][col] == AI) {
          return -10;
        }
      }
    }

    // Checking for Diagonals for X or O victory.
    if (b[0][0] == b[1][1] && b[1][1] == b[2][2]) {
      if (b[0][0] == PLAYER) {
        return 10;
      } else if (b[0][0] == AI) {
        return -10;
      }
    }

    if (b[0][2] == b[1][1] && b[1][1] == b[2][0]) {
      if (b[0][2] == PLAYER) {
        return 10;
      } else if (b[0][2] == AI) {
        return -10;
      }
    }

    // Else if none of them have won then return 0
    return 0;
  }

  int minimax(List<List<int>> board, int depth, bool isMax) {
    int score = evaluate(board);

    // If Maximizer has won the game return his/her
    // evaluated score
    if (score == 10) {
      return score;
    }

    // If Minimizer has won the game return his/her
    // evaluated score
    if (score == -10) {
      return score;
    }

    // If there are no more moves and no winner then
    // it is a tie
    if (isMovesLeft(board) == false) {
      return 0;
    }

    // If this maximizer's move
    if (isMax) {
      int best = -1000;

      // Traverse all cells
      for (int i = 0; i < 3; i++) {
        for (int j = 0; j < 3; j++) {
          // Check if cell is empty
          if (board[i][j] == EMPTY) {
            // Make the move
            board[i][j] = PLAYER;

            // Call minimax recursively and choose
            // the maximum value
            best = max(best, minimax(board, depth + 1, !isMax));

            // Undo the move
            board[i][j] = EMPTY;
          }
        }
      }
      return best;
    }

    // If this minimizer's move
    else {
      int best = 1000;

      // Traverse all cells
      for (int i = 0; i < 3; i++) {
        for (int j = 0; j < 3; j++) {
          // Check if cell is empty
          if (board[i][j] == EMPTY) {
            // Make the move
            board[i][j] = AI;

            // Call minimax recursively and choose
            // the minimum value
            best = min(best, minimax(board, depth + 1, !isMax));

            // Undo the move
            board[i][j] = EMPTY;
          }
        }
      }
      return best;
    }
  }

  // This will return the best possible move for the player
  Move findBestMove(List<List<int>> board) {
    int bestVal = -1000;
    Move bestMove = Move(-1, -1);

    // Traverse all cells, evaluate minimax function for
    // all empty cells. And return the cell with optimal
    // value.
    for (int i = 0; i < 3; i++) {
      for (int j = 0; j < 3; j++) {
        // Check if cell is empty
        if (board[i][j] == EMPTY) {
          // Make the move
          board[i][j] = PLAYER;

          // compute evaluation function for this
          // move.
          int moveVal = minimax(board, 0, false);

          // Undo the move
          board[i][j] = EMPTY;

          // If the value of the current move is
          // more than the best value, then update
          // best/
          if (moveVal > bestVal) {
            bestMove = Move(i, j);
            bestVal = moveVal;
          }
        }
      }
    }

    return bestMove;
  }
}

class Move {
  int row, col;
  Move(this.row, this.col);
}
