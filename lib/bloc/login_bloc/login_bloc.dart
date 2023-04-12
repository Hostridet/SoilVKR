import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../repository/LoginRepository.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginRepository _loginRepository;
  LoginBloc(this._loginRepository) : super(LoginInitial()) {
    on<LoginUser>((event, emit) async {
      emit(LoginLoadingState());
      try {
        emit(LoginLoadedState());
        // emit(LoginWrongState());
        // emit(LoginEmptyState());
      }
      catch (e) {
        emit(LoginErrorState(e.toString()));
      }
    });
  }
}
