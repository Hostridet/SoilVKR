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

class SoilAddConGroundState extends SoilState {
  final List<Soil> soilList;
  final List<Ground> groundList;

  SoilAddConGroundState(this.soilList, this.groundList);
}

class SoilAddConPlantState extends SoilState {
  final List<Soil> soilList;
  final List<Plant> plantList;

  SoilAddConPlantState(this.soilList, this.plantList);
}

class SoilAddPointState extends SoilState {
  final List<Soil> soilList;
  final List<Point> pointList;

  SoilAddPointState(this.soilList, this.pointList);
}

class WaterPointConState extends SoilState {
  final List<PointWater> waterPointList;

  WaterPointConState(this.waterPointList);
}

class WaterPointAddConState extends SoilState {
  final List<Water> waterList;
  final List<Point> pointList;

  WaterPointAddConState(this.waterList, this.pointList);
}

class ClimatPointConState extends SoilState {
  final List<PointClimat> climatPointList;

  ClimatPointConState(this.climatPointList);
}

class ClimatPointAddConState extends SoilState {
  final List<Climat> climatList;
  final List<Point> pointList;

  ClimatPointAddConState(this.climatList, this.pointList);
}

class ReliefPointConState extends SoilState {
  final List<PointRelief> reliefPointList;

  ReliefPointConState(this.reliefPointList);
}

class ReliefPointAddConState extends SoilState {
  final List<Relief> reliefList;
  final List<Point> pointList;

  ReliefPointAddConState(this.reliefList, this.pointList);
}

class FoundationPointConState extends SoilState {
  final List<PointFoundation> foundationPointList;

  FoundationPointConState(this.foundationPointList);
}

class FoundationPointAddConState extends SoilState {
  final List<Foundation> foundationList;
  final List<Point> pointList;

  FoundationPointAddConState(this.foundationList, this.pointList);
}
