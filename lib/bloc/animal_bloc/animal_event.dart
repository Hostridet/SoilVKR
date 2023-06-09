part of 'animal_bloc.dart';

@immutable
abstract class AnimalEvent {}

class AnimalGetEvent extends AnimalEvent {}

class AnimalViewUpdateEvent extends AnimalEvent {}

class AnimalUpdateEvent extends AnimalEvent {
  final String name;
  final String description;

  AnimalUpdateEvent(this.name, this.description);
}
