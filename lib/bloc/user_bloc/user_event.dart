part of 'user_bloc.dart';

@immutable
abstract class UserEvent {}

class UserGetEvent extends UserEvent {}

class UserUpdateEvent extends UserEvent {
  User user;

  UserUpdateEvent(this.user);
}

class UserGetByIdEvent extends UserEvent {
  final int id;

  UserGetByIdEvent(this.id);
}

class UserGetAllEvent extends UserEvent {}
