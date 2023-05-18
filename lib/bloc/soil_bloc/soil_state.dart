part of 'soil_bloc.dart';

@immutable
abstract class SoilState {}

class SoilInitial extends SoilState {}

class SoilLoadingState extends SoilState {}

class SoilLoadedState extends SoilState {
  final List<Soil> soilList;

  SoilLoadedState(this.soilList);
}

class SoilErrorState extends SoilState {
  final String error;

  SoilErrorState(this.error);
}
