part of 'user_bloc.dart';

@immutable
abstract class UserState {}

class UserInitial extends UserState {}

class UserLoadingState extends UserState {}

class UserLoadedState extends UserState {
  final String login;
  final String name;
  final String patr;

  UserLoadedState(this.login, this.name, this.patr);
}

class UserErrorState extends UserState {
  final String error;

  UserErrorState(this.error);
}
