import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:soil/repository/LoginRepository.dart';

part 'splash_event.dart';
part 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc() : super(SplashInitial()) {
    on<SplashLoad>((event, emit) async {
      LoginRepository loginRepository = LoginRepository();
      if (await loginRepository.isAuthorize()) {
        emit(SplashDisabledState());
      }
      else {
        emit(SplashLoadedState());
      }
    });
  }
}
