import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../models/User.dart';
import '../../repository/UserRepository.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository _userRepository;
  UserBloc(this._userRepository) : super(UserInitial()) {
    on<UserGetEvent>((event, emit) async {
      try {
        User user = await _userRepository.getUser();
        emit(UserLoadedState(user));
      }
      catch(e) {
        emit(UserErrorState(e.toString()));
      }
    });

    on<UserUpdateEvent>((event, emit) async {
      try {
        _userRepository.updateUser(event.user);
      }
      catch(e) {
        emit(UserErrorState(e.toString()));
      }
    });
  }
}
