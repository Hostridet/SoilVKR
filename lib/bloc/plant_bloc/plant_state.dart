part of 'plant_bloc.dart';

@immutable
abstract class PlantState {}

class PlantInitial extends PlantState {}

class PlantLoadingState extends PlantState {}

class PlantLoadedState extends PlantState {
  final List<Plant> plantList;
  final bool isAdmin;

  PlantLoadedState(this.plantList, this.isAdmin);
}

class PlantErrorState extends PlantState {
  final String error;

  PlantErrorState(this.error);
}

class PlantViewUpdateState extends PlantState {}

class PlantAnimalConState extends PlantState {
  List<PlantAnimal> plantAnimalList;

  PlantAnimalConState(this.plantAnimalList);
}

class PlantAddConAnimalState extends PlantState {
  final List<Plant> plantList;
  final List<Animal> animalList;

  PlantAddConAnimalState(this.plantList, this.animalList);
}