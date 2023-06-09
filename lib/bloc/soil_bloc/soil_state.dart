part of 'soil_bloc.dart';

@immutable
abstract class SoilState {}

class SoilInitial extends SoilState {}

class SoilLoadingState extends SoilState {}

class SoilLoadedState extends SoilState {
  final List<Soil> soilList;
  final bool isAdmin;

  SoilLoadedState(this.soilList, this.isAdmin);
}

class SoilErrorState extends SoilState {
  final String error;

  SoilErrorState(this.error);
}

class SoilViewUpdateState extends SoilState {}