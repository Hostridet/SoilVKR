part of 'water_bloc.dart';

@immutable
abstract class WaterState {}

class WaterInitial extends WaterState {}

class WaterLoadingState extends WaterState {}

class WaterLoadedState extends WaterState {
  final List<Water> animalList;
  final bool isAdmin;

  WaterLoadedState(this.animalList, this.isAdmin);
}

class WaterErrorState extends WaterState {
  final String error;

  WaterErrorState(this.error);
}

class WaterViewUpdateState extends WaterState {}
