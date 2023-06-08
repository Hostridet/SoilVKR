part of 'user_bloc.dart';

@immutable
abstract class UserState {}

class UserInitial extends UserState {}

class UserLoadingState extends UserState {}

class UserLoadedState extends UserState {
  User user;
  bool isAdmin;

  UserLoadedState(this.user, this.isAdmin);
}

class UserLoadedAllState extends UserState {
  final List<User> userList;

  UserLoadedAllState(this.userList);
}

class UserErrorState extends UserState {
  final String error;

  UserErrorState(this.error);
}
