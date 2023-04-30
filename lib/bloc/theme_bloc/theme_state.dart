part of 'theme_bloc.dart';

@immutable
abstract class ThemeState {}

class ThemeInitial extends ThemeState {}

class ThemeWhiteState extends ThemeState {
  ThemeData theme;

  ThemeWhiteState(this.theme);
}


class ThemeDarkState extends ThemeState {
  ThemeData theme;

  ThemeDarkState(this.theme);
}
