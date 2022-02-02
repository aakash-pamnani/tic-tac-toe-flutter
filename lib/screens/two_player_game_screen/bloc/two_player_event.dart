part of 'two_player_bloc.dart';

@immutable
abstract class TwoPlayerEvent {}

class TwoPlayerGameInitilize extends TwoPlayerEvent {}

class TileTap extends TwoPlayerEvent {
  final int x;
  final int y;

  TileTap(this.x, this.y);

  @override
  String toString() => 'TileTap(x: $x, y: $y)';
}
