part of 'ground_bloc.dart';

@immutable
abstract class GroundEvent {}

class GroundGetEvent extends GroundEvent {}

class GroundViewUpdateEvent extends GroundEvent {}

class GroundUpdateEvent extends GroundEvent {
  final String name;
  final String description;

  GroundUpdateEvent(this.name, this.description);
}