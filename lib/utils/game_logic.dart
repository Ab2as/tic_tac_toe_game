class Player {
  static const x = "X";
  static const o = "O";
  static const empty = "";
}

class Game {
  static final boardLength = 9; // we will create a board of 3*3 blocks;
  static final blockSize = 100.0;

  //Creating the empty board
  List<String>? board;

  static List<String>? initGameBoard() =>
      List.generate(boardLength, (index) => Player.empty);

  //building the winner check algorithm
  //for this we will first declare a scoreboard in our main file
  bool winnerCheck(
      String player, int index, List<int> scoreBoard, int gridSize) {
    //first let's declare the row and col
    int row = index ~/ 3;
    int col = index % 3;
    int score = player == "X" ? 1 : -1;

    scoreBoard[row] += score;
    scoreBoard[gridSize + col] += score;
    if (row == col) scoreBoard[2 * gridSize] += score;
    if (gridSize - 1 - col == row) scoreBoard[2 * gridSize + 1] += score;

    //checking default if we have 3 or -3 in the score board
    if (scoreBoard.contains(3) || scoreBoard.contains(-3)) {
      return true;
    }

    return false;
  }
}
