import 'dart:io';

// Global variables
late List<String> board; // Game board
late String currentPlayer; // Current player (X or O)
late bool
    gameFinished; // Variable indicating whether the game is won by a player

void main() {
  resetGame();
  startGame();
}

// Fun to reset the game
void resetGame() {
  board = ["1", "2", "3", "4", "5", "6", "7", "8", "9"];
  currentPlayer = "X";
  gameFinished = false;
  displayBoard();
}

// Fun to print the game board design.
void displayBoard() {
  for (var i = 0; i < 9; i += 3) {
    print("${board[i]} | ${board[i + 1]} | ${board[i + 2]}");
    if (i < 6) print("---------");
  }
}

// Fun to start the Tic-Tac-Toe game.
void startGame() {
  print("Welcome to my Tic-Tac-Toe game 🫡");

  while (!gameFinished) {
    print("\n$currentPlayer is turn. Enter your move (1-9): ");
    var move = int.tryParse(stdin.readLineSync() ?? '');

    if (move != null && move >= 1 && move <= 9) {
      makeMove(move);
    } else {
      print("Invalid input! Please enter a number from 1 to 9.");
    }
  }

  print("Game finished.");
}

// Fun to validate the player move.
bool makeMove(int position) {
  if (position < 1 ||
      position > 9 ||
      board[position - 1] == "X" ||
      board[position - 1] == "O") {
    print("You can't move here! Please try again.");
    return false;
  }

  board[position - 1] = currentPlayer;
  displayBoard();

  if (checkIfWin()) {
    print("Great! $currentPlayer wins 😍");
    gameFinished = true;
  } else if (isBoardFull()) {
    print("Wow it's a draw!");
    gameFinished = true;
  } else {
    currentPlayer = (currentPlayer == "X") ? "O" : "X";
  }

  return true;
}

// Fun to check if there is a winner.
bool checkIfWin() {
  // Check diagonals, rows, and columns for a win.
  for (int i = 0; i < 3; i++) {
    if (board[i] == board[i + 3] && board[i + 3] == board[i + 6]) {
      return true; // Check the columns equalyte
    }

    if (board[i * 3] == board[i * 3 + 1] &&
        board[i * 3 + 1] == board[i * 3 + 2]) {
      return true; // Check rows
    }
  }

  if (board[2] == board[4] && board[4] == board[6]) {
    return true; // Check diagonal from top-right to bottom-left
  }

  if (board[0] == board[4] && board[4] == board[8]) {
    return true; // Check diagonal from top-left to bottom-right
  }

  return false;
}

bool isBoardFull() {
  int countX = 0;
  int countO = 0;

  for (String cell in board) {
    if (cell == "X") {
      countX++;
    } else if (cell == "O") {
      countO++;
    }
  }

  // return (countX + countO) == 9? true : false;
  return (countX + countO) == 9;
}
