part of 'game_screen_bloc.dart';

@immutable
abstract class GameScreenState {
  const GameScreenState(this.data, this.isXTurn);
  final List<List<String>> data;
  final bool isXTurn;
}

class GameScreenInitial extends GameScreenState {
  final int xWin;
  final int oWin;
  final int draw;
  const GameScreenInitial(
      {required List<List<String>> data,
      required this.xWin,
      required this.oWin,
      required this.draw,
      required bool isXTurn})
      : super(data, isXTurn);

  @override
  String toString() =>
      'GameScreenInitial(xWin: $xWin, oWin: $oWin, draw: $draw)';

 
}

class GameBoardChanged extends GameScreenState {
  const GameBoardChanged(List<List<String>> data, bool isXTurn)
      : super(data, isXTurn);
}

class GameOver extends GameScreenState {
  final String winner;
  final int xWins;
  final int oWins;
  final int draws;

  const GameOver(
      {required List<List<String>> data,
      required this.winner,
      required this.xWins,
      required this.oWins,
      required this.draws,
      required bool isXTurn})
      : super(data, isXTurn);

  @override
  String toString() {
    return 'GameOver(winner: $winner, xWins: $xWins, oWins: $oWins, draws: $draws)';
  }
}
