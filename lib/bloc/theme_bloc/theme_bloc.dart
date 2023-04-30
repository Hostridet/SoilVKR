import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'theme_event.dart';
part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(ThemeInitial()) {
    on<ThemeSetEvent>((event, emit) {
      ThemeData theme = ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
        primaryColor: Color(0xFFFEDACC),
      );

      emit(ThemeWhiteState(theme));
    });

    on<ThemeSetDarkEvent>((event, emit) {
      ThemeData theme = ThemeData(
        brightness: Brightness.dark,
        // primaryColor: Color(0xFFFEDACC),
      );
      // Theme.of(context).colorScheme.primaryContainer

      emit(ThemeDarkState(theme));
    });
    on<ThemeCheckEvent>((event, emit) async  {
      ThemeData darkTheme = ThemeData(
        brightness: Brightness.dark,
      );
      ThemeData lightTheme = ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
        primaryColor: Color(0xFFFEDACC),
      );
      final prefs = await SharedPreferences.getInstance();
      int? flag = prefs.getInt("mode");
      if (flag == 0 || flag == null) {
        emit(ThemeWhiteState(lightTheme));
      }
      else {
        emit(ThemeDarkState(darkTheme));
      }
    });
  }
}
