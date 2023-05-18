part of 'animal_bloc.dart';

@immutable
abstract class AnimalState {}

class AnimalInitial extends AnimalState {}

class AnimalLoadingState extends AnimalState {}

class AnimalLoadedState extends AnimalState {
  final List<Animal> animalList;

  AnimalLoadedState(this.animalList);
}

class AnimalErrorState extends AnimalState {
  final String error;

  AnimalErrorState(this.error);
}
