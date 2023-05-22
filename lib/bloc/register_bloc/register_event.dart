part of 'register_bloc.dart';

@immutable
abstract class RegisterEvent {}

class RegisterMakeEvent extends RegisterEvent {
  final String email;
  final String login;
  final String password;

  RegisterMakeEvent(this.email, this.login, this.password);
}
