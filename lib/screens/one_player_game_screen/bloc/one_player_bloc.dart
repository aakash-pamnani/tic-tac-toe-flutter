import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

part 'one_player_event.dart';
part 'one_player_state.dart';

class OnePlayerBloc extends Bloc<OnePlayerEvent, OnePlayerState> {
  OnePlayerBloc()
      : super(const OnePlayerInitialState(data: [
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

    on<OnePlayerGameInitilize>((event, emit) {
      //gives x and o first chance in alertante games
      isXTurn = true;

      // Set moves count to 0 on every new game
      move = 0;
      // Set Game array to empty on every new game
      boardArray = List<List<String>>.generate(
          3,
          (index) => List<String>.generate(
                3,
                (_) => "",
              ));
      emit(OnePlayerInitialState(
        data: boardArray,
        xWin: xWins,
        oWin: oWins,
        draw: draw,
        isXTurn: isXTurn,
      ));
    });

    on<TileTapByAi>((event, emit) {
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
          emit(OnePlayerGameOver(
              data: boardArray,
              winner: winner,
              xWins: xWins,
              oWins: oWins,
              draws: draw,
              isXTurn: isXTurn));
        } else {
          // Change the board if there is no winner or draw.
          HapticFeedback.lightImpact();
          emit(OnePlayerGameBoardChanged(boardArray, isXTurn));
        }
      }
    });

    on<TileTapByPlayer>((event, emit) {
      if (!isXTurn) {
        return;
      }
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
          emit(OnePlayerGameOver(
              data: boardArray,
              winner: winner,
              xWins: xWins,
              oWins: oWins,
              draws: draw,
              isXTurn: isXTurn));
        } else {
          // Change the board if there is no winner or draw.
          HapticFeedback.lightImpact();
          emit(OnePlayerGameBoardChanged(boardArray, isXTurn));
          runAi(boardArray, move);
        }
      }
    });
  }
  @override
  void onTransition(Transition<OnePlayerEvent, OnePlayerState> transition) {
    if (kDebugMode) {
      print(transition);
    }
    super.onTransition(transition);
  }

  void emitStateAfterTileTap() {}

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

  void runAi(List<List<String>> boardArray, int move) {
    // check if there is any winnig position
    for (int i = 0; i < 3; i++) {
      for (int j = 0; j < 3; j++) {
        if (boardArray[i][j].isNotEmpty) {
          continue;
        } else {
          List<List<String>> tempBoardArray = [
            [...boardArray[0]],
            [...boardArray[1]],
            [...boardArray[2]]
          ]..[i][j] = 'o';
          String winner = checkWinnerOrDraw(tempBoardArray, move);

          if (winner == 'o') {
            add(TileTapByAi(i, j));
            return;
          }
        }
      }
    }

    // check if there is any blocking position
    for (int i = 0; i < 3; i++) {
      for (int j = 0; j < 3; j++) {
        if (boardArray[i][j].isNotEmpty) {
          continue;
        } else {
          List<List<String>> tempBoardArray = [
            [...boardArray[0]],
            [...boardArray[1]],
            [...boardArray[2]]
          ]..[i][j] = 'x';

          String winner = checkWinnerOrDraw(tempBoardArray, move);

          if (winner == 'x') {
            add(TileTapByAi(i, j));
            return;
          }
        }
      }
    }

    // else make any move

    for (int i = 0; i < 3; i++) {
      for (int j = 0; j < 3; j++) {
        if (boardArray[i][j] == "") {
          add(TileTapByAi(i, j));
          return;
        }
      }
    }
  }
}
