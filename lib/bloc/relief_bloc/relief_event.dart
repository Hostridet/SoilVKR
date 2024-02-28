part of 'relief_bloc.dart';

@immutable
abstract class ReliefEvent {}

class ReliefGetEvent extends ReliefEvent {}

class ReliefViewUpdateEvent extends ReliefEvent {}

class ReliefUpdateEvent extends ReliefEvent {
  final String name;
  final String description;

  ReliefUpdateEvent(this.name, this.description);
}
