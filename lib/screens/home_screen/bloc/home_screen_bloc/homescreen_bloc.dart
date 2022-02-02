import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';


part 'homescreen_event.dart';
part 'homescreen_state.dart';

class HomeScreenBloc extends Bloc<HomescreenEvent, HomeScreenState> {
  HomeScreenBloc() : super(HomeScreenInitial()) {
    on<ShowOptionDailogEvent>((event, emit) {
      emit(ShowOptionDailogState());
    });

    on<ShowJoinGameDailogEvent>((event, emit) {
      emit(ShowJoinGameDailogState());
    });

    on<ShowCreatingGameDailogEvent>((event, emit) {
      createNewGame();
      emit(ShowCreatingGameDailogState());
    });
  }

  @override
  void onTransition(Transition<HomescreenEvent, HomeScreenState> transition) {
    if (kDebugMode) {
      print(transition);
    }
    super.onTransition(transition);
  }

  void createNewGame() {}
}
