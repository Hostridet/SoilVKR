import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'light_event.dart';
part 'light_state.dart';

class LightBloc extends Bloc<LightEvent, LightState> {
  LightBloc() : super(LightInitial()) {
    on<LightGetEvent>((event, emit) async {
      final prefs = await SharedPreferences.getInstance();
      int intLight = 0;
      bool light;
      prefs.getInt("mode") == null
          ? light = true
          : intLight = prefs.getInt("mode")!;
      (intLight == 1)
          ? light = true
          : light = false;
      emit(LightLoadedState(light));
    });
  }
}
