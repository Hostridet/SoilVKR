part of 'profile_bloc.dart';

@immutable
abstract class ProfileEvent {}

class GetProfileEvent extends ProfileEvent {
  final int id;

  GetProfileEvent(this.id);
}
class ChangeAgeEvent extends ProfileEvent {
  final int id;
  final int age;

  ChangeAgeEvent(this.id, this.age);
}

class ChangeFIOEvent extends ProfileEvent {
  final int id;
  final String fio;

  ChangeFIOEvent(this.id, this.fio);
}

class ChangePhoneEvent extends ProfileEvent {
  final int id;
  final String phone;

  ChangePhoneEvent(this.id, this.phone);
}

class ChangeEmailEvent extends ProfileEvent {
  final int id;
  final String email;

  ChangeEmailEvent(this.id, this.email);
}

