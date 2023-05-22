import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../repository/RegisterRepository.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterRepository _registerRepository;
  RegisterBloc(this._registerRepository) : super(RegisterInitial()) {
    on<RegisterMakeEvent>((event, emit) async {
      print("${event.login} ${event.password} ${event.email}");
      if (event.login.isNotEmpty && event.email.isNotEmpty && event.login.isNotEmpty) {
        String statusCode = await _registerRepository.makeRegister(event.email, event.login, event.password);
        if (statusCode == 200) {
          emit(RegisterSuccessState());
        }
        else {
          emit(RegisterErrorState("Неправильно заполнены поля"));
        }
      }
      else {
        emit(RegisterErrorState("Все поля должны быть заполнены"));
      }
    });
  }
}
