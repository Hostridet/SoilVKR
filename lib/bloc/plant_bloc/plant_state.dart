part of 'plant_bloc.dart';

@immutable
abstract class PlantState {}

class PlantInitial extends PlantState {}

class PlantLoadingState extends PlantState {}

class PlantLoadedState extends PlantState {
  final List<Plant> plantList;

  PlantLoadedState(this.plantList);
}

class PlantErrorState extends PlantState {
  final String error;

  PlantErrorState(this.error);
}