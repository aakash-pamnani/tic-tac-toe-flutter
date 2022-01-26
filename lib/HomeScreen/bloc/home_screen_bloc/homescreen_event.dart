part of 'homescreen_bloc.dart';

@immutable
abstract class HomescreenEvent {}

class ShowOptionDailogEvent extends HomescreenEvent{}

class ShowJoinGameDailogEvent extends HomescreenEvent{}


class ShowCreatingGameDailogEvent extends HomescreenEvent{}

class ShowWaitingForPlayerDailogEvent extends HomescreenEvent{}




