part of 'one_player_bloc.dart';






@immutable
abstract class OnePlayerEvent {}

class OnePlayerGameInitilize extends OnePlayerEvent {}

class TileTapByPlayer extends OnePlayerEvent {
  final int x;
  final int y;

  TileTapByPlayer(this.x, this.y);

  @override
  String toString() => 'TileTapByPlayer(x: $x, y: $y)';
}


class TileTapByAi extends OnePlayerEvent {
  final int x;
  final int y;

  TileTapByAi(this.x, this.y);

  @override
  String toString() => 'TileTapByAi(x: $x, y: $y)';
}
