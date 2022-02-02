import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';


part 'theme_event.dart';
part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(LightTheme()) {
    on<ThemeChanged>((event, emit) {
      if (event.isDarkTheme) {
        emit(DarkTheme());
      } else {
        emit(LightTheme());
      }
    });
  }

  @override
  void onTransition(Transition<ThemeEvent, ThemeState> transition) {
    if (kDebugMode) {
      print(transition);
    }
    super.onTransition(transition);
  }
}
