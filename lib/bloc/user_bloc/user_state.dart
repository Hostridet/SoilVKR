part of 'user_bloc.dart';

@immutable
abstract class UserState {}

class UserInitial extends UserState {}

class UserLoadingState extends UserState {}

class UserLoadedState extends UserState {
  User user;

  UserLoadedState(this.user);
}

class UserErrorState extends UserState {
  final String error;

  UserErrorState(this.error);
}
