part of 'game_screen_bloc.dart';

@immutable
abstract class GameScreenEvent {}

class GameInitilize extends GameScreenEvent {}

class TileTap extends GameScreenEvent {
  final int x;
  final int y;

  TileTap(this.x, this.y);

  @override
  String toString() => 'TileTap(x: $x, y: $y)';
}
