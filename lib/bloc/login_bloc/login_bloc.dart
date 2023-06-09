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
      if (event.login.isEmpty || event.password.isEmpty) {
        emit(LoginEmptyState());
        return;
      }
      try {
        int statusCode = await _loginRepository.getLogIn(event.login, event.password);
        if (statusCode == 200) {
          emit(LoginLoadedState());
        }
        if (statusCode == 401) {
          emit(LoginWrongState());
        }
        //emit(LoginLoadedState());
        // emit(LoginWrongState());
        // emit(LoginEmptyState());
      }
      catch (e) {
        emit(LoginErrorState(e.toString()));
      }
    });
    on<LoginIsAuthorizeEvent>((event, emit) async {
      emit(LoginLoadingState());
      if (await _loginRepository.isAuthorize()) {
        emit(LoginWrongState());
      }
    });
  }
}
