import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../repository/UserRepository.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository _userRepository;
  UserBloc(this._userRepository) : super(UserInitial()) {
    on<UserGetEvent>((event, emit) async {
      //emit(UserLoadingState());
      emit(UserLoadedState("host", "Никита", "Олегович"));
    });
  }
}
