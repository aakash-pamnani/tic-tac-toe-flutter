part of 'two_player_bloc.dart';

@immutable
abstract class TwoPlayerState {
  const TwoPlayerState(this.data, this.isXTurn);
  final List<List<String>> data;
  final bool isXTurn;
}

class TwoPlayerInitialState extends TwoPlayerState {
  final int xWin;
  final int oWin;
  final int draw;
  const TwoPlayerInitialState(
      {required List<List<String>> data,
      required this.xWin,
      required this.oWin,
      required this.draw,
      required bool isXTurn})
      : super(data, isXTurn);

  @override
  String toString() =>
      'TwoPlayerInitialState(xWin: $xWin, oWin: $oWin, draw: $draw)';

 
}

class TwoPlayerGameBoardChanged extends TwoPlayerState {
  const TwoPlayerGameBoardChanged(List<List<String>> data, bool isXTurn)
      : super(data, isXTurn);
}

class TwoPlayerGameOver extends TwoPlayerState {
  final String winner;
  final int xWins;
  final int oWins;
  final int draws;

  const TwoPlayerGameOver(
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
