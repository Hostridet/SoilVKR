part of 'plant_bloc.dart';

@immutable
abstract class PlantEvent {}

class PlantGetEvent extends PlantEvent {}

class PlantViewUpdateEvent extends PlantEvent {}

class PlantUpdateEvent extends PlantEvent {
  final String name;
  final String description;
  final bool isFodder;

  PlantUpdateEvent(this.name, this.description, this.isFodder);
}

class PlantGetAnimalConEvent extends PlantEvent {}