import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

part 'two_player_event.dart';
part 'two_player_state.dart';

class TwoPlayerBloc extends Bloc<TwoPlayerEvent, TwoPlayerState> {
  TwoPlayerBloc()
      : super(const TwoPlayerInitialState(data: [
          ["", "", ""],
          ["", "", ""],
          ["", "", ""]
        ], xWin: 0, oWin: 0, draw: 0, isXTurn: true)) {
    //generate 3x3 empty array
    List<List<String>> boardArray = List<List<String>>.generate(
      3,
      (index) => List<String>.generate(
        3,
        (_) => "",
      ),
    );

    //initialize game state
    bool isXTurn = true;

    int xWins = 0;
    int oWins = 0;
    int draw = 0;
    int move = 0;

    on<TwoPlayerGameInitilize>((event, emit) {
      //gives x and o first chance in alertante games
      isXTurn = (xWins + oWins + draw) % 2 == 0;

// Set moves count to 0 on every new game
      move = 0;
      // Set Game array to empty on every new game
      boardArray = List<List<String>>.generate(
          3,
          (index) => List<String>.generate(
                3,
                (_) => "",
              ));
      emit(TwoPlayerInitialState(
        data: boardArray,
        xWin: xWins,
        oWin: oWins,
        draw: draw,
        isXTurn: isXTurn,
      ));
    });

    on<TileTap>((event, emit) {
      // Check if the tile clicked is alerady filled or not.
      // if not filled then fill the tile else do nothing.
      if (boardArray[event.x][event.y] == "") {
        // Increment move counter on title tap.
        move++;
        // Set the tile value X or O based on the current player turn.
        boardArray[event.x][event.y] = isXTurn ? "x" : "o";
        // Change turn to other player.
        isXTurn = !isXTurn;
        //check if there is winner or not after tile tap.
        String winner = checkWinnerOrDraw(boardArray, move);

        // If there is winner or game draw then game over.
        if (winner.isNotEmpty) {
          if (winner == 'x') {
            // If x wins increment xwins counter.
            xWins++;
          } else if (winner == 'o') {
            // If o wins increment owins counter.
            oWins++;
          } else if (winner == "draw") {
            // If draw  increment draw counter.
            draw++;
          }
          HapticFeedback.heavyImpact();
          // Emit game over state with latest data.
          emit(TwoPlayerGameOver(
              data: boardArray,
              winner: winner,
              xWins: xWins,
              oWins: oWins,
              draws: draw,
              isXTurn: isXTurn));
        } else {
          // Change the board if there is no winner or draw.
          HapticFeedback.lightImpact();
          emit(TwoPlayerGameBoardChanged(boardArray, isXTurn));
        }
      }
    });
  }
  @override
  void onTransition(Transition<TwoPlayerEvent, TwoPlayerState> transition) {
    if (kDebugMode) {
      print(transition);
    }
    super.onTransition(transition);
  }

  /// Checks for winner or draw in the game.
  String checkWinnerOrDraw(List<List<String>> boardArray, int moves) {
    String winner = "";
    //check for horizontal and vertical winner
    for (int i = 0; i < 3; i++) {
      if (boardArray[i][0] == "x" &&
          boardArray[i][1] == "x" &&
          boardArray[i][2] == "x") {
        winner = "x";
        break;
      } else if (boardArray[i][0] == "o" &&
          boardArray[i][1] == "o" &&
          boardArray[i][2] == "o") {
        winner = "o";
        break;
      } else if (boardArray[0][i] == "x" &&
          boardArray[1][i] == "x" &&
          boardArray[2][i] == "x") {
        winner = "x";
        break;
      } else if (boardArray[0][i] == "o" &&
          boardArray[1][i] == "o" &&
          boardArray[2][i] == "o") {
        winner = "o";
        break;
      }
    }

    if ((boardArray[0][0] == "x" &&
            boardArray[1][1] == "x" &&
            boardArray[2][2] == "x") ||
        (boardArray[0][2] == "x" &&
            boardArray[1][1] == "x" &&
            boardArray[2][0] == "x")) {
      winner = "x";
    } else if ((boardArray[0][0] == "o" &&
            boardArray[1][1] == "o" &&
            boardArray[2][2] == "o") ||
        (boardArray[0][2] == "o" &&
            boardArray[1][1] == "o" &&
            boardArray[2][0] == "o")) {
      winner = "o";
    }

    if (moves == 9) {
      winner = "draw";
    }
    return winner;
  }
}
