part of 'cur_foundation_bloc.dart';

@immutable
abstract class CurFoundationEvent {}

class CurFoundationGetEvent extends CurFoundationEvent {
  final int id;

  CurFoundationGetEvent(this.id);
}
