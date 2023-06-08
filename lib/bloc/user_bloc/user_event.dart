part of 'user_bloc.dart';

@immutable
abstract class UserEvent {}

class UserGetEvent extends UserEvent {}

class UserUpdateEvent extends UserEvent {
  User user;

  UserUpdateEvent(this.user);
}

class UserGetAllEvent extends UserEvent {}
