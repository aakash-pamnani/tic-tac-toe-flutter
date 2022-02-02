part of 'theme_bloc.dart';

@immutable
abstract class ThemeEvent {}

class ThemeChanged extends ThemeEvent {
  final bool isDarkTheme;

  ThemeChanged(this.isDarkTheme);
}
