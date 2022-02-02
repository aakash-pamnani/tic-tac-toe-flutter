part of 'one_player_bloc.dart';



@immutable
abstract class OnePlayerState {
  const OnePlayerState(this.data, this.isXTurn);
  final List<List<String>> data;
  final bool isXTurn;
}

class OnePlayerInitialState extends OnePlayerState {
  final int xWin;
  final int oWin;
  final int draw;
  const OnePlayerInitialState(
      {required List<List<String>> data,
      required this.xWin,
      required this.oWin,
      required this.draw,
      required bool isXTurn})
      : super(data, isXTurn);

  @override
  String toString() =>
      'OnePlayerInitialState(xWin: $xWin, oWin: $oWin, draw: $draw)';

 
}

class OnePlayerGameBoardChanged extends OnePlayerState {
  const OnePlayerGameBoardChanged(List<List<String>> data, bool isXTurn)
      : super(data, isXTurn);
}

class OnePlayerGameOver extends OnePlayerState {
  final String winner;
  final int xWins;
  final int oWins;
  final int draws;

  const OnePlayerGameOver(
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

