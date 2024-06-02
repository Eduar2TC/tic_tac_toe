class WinningLine {
  final int start;
  final int end;
  WinningLine(this.start, this.end);
}

const int EMPTY = 0;
WinningLine? getWinningLine(List<List<int>> board) {
  // Check all rows
  for (int row = 0; row < 3; row++) {
    if (board[row][0] != EMPTY &&
        board[row][0] == board[row][1] &&
        board[row][1] == board[row][2]) {
      return WinningLine(row * 3, row * 3 + 2);
    }
  }

  // Check all columns
  for (int col = 0; col < 3; col++) {
    if (board[0][col] != EMPTY &&
        board[0][col] == board[1][col] &&
        board[1][col] == board[2][col]) {
      return WinningLine(col, col + 6);
    }
  }

  // Check diagonals
  if (board[0][0] != EMPTY &&
      board[0][0] == board[1][1] &&
      board[1][1] == board[2][2]) {
    return WinningLine(0, 8);
  }
  if (board[0][2] != EMPTY &&
      board[0][2] == board[1][1] &&
      board[1][1] == board[2][0]) {
    return WinningLine(2, 6);
  }

  // If no winning line, return null
  return null;
}
