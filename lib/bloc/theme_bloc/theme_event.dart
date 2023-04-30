part of 'theme_bloc.dart';

@immutable
abstract class ThemeEvent {}

class ThemeSetEvent extends ThemeEvent {}

class ThemeSetDarkEvent extends ThemeEvent {}

class ThemeCheckEvent extends ThemeEvent {}
