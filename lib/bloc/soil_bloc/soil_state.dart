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

class SoilGroundConState extends SoilState {
  final List<SoilGround> soilGroundList;

  SoilGroundConState(this.soilGroundList);
}

class SoilPlantConState extends SoilState {
  final List<SoilPlant> soilPlantList;

  SoilPlantConState(this.soilPlantList);
}

class SoilPointConState extends SoilState {
  final List<SoilPoint> soilPointList;

  SoilPointConState(this.soilPointList);

  get soilGroundList => null;
}