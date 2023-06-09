part of 'soil_bloc.dart';

@immutable
abstract class SoilEvent {}

class SoilGetEvent extends SoilEvent {}

class SoilViewUpdateEvent extends SoilEvent {}

class SoilUpdateEvent extends SoilEvent {
  final String name;
  final String description;

  SoilUpdateEvent(this.name, this.description);
}