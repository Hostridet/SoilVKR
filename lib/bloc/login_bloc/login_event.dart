part of 'login_bloc.dart';

@immutable
abstract class LoginEvent {}

class LoginUser extends LoginEvent {
  final String login;
  final String password;

  LoginUser(this.login, this.password);
}

class LoginIsAuthorizeEvent extends LoginEvent {}
