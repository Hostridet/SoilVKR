import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../models/User.dart';
import '../../repository/AdminRepository.dart';
import '../../repository/UserRepository.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository _userRepository;
  UserBloc(this._userRepository) : super(UserInitial()) {
    on<UserGetEvent>((event, emit) async {
      emit(UserLoadingState());
      try {
        User user = await _userRepository.getUser();
        bool isAdmin = await AdminRepository.isAdmin();
        emit(UserLoadedState(user, isAdmin));
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

    on<UserGetAllEvent>((event, emit) async {
      emit(UserLoadingState());
      try {
        List<User> userList = await _userRepository.getAllUser();
        emit(UserLoadedAllState(userList));
      }
      catch(e) {
        emit(UserErrorState(e.toString()));
      }
    });
  }
}
