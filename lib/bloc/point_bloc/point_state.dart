part of 'point_bloc.dart';

@immutable
abstract class PointState {}

class PointInitial extends PointState {}

class PointLoadingState extends PointState {}

class PointLoadedState extends PointState {
  final List<Point> pointList;
  final bool isAdmin;

  PointLoadedState(this.pointList, this.isAdmin);
}

class PointErrorState extends PointState {
  final String error;

  PointErrorState(this.error);
}

class PointLoadedOneState extends PointState {
  final Point point;

  PointLoadedOneState(this.point);
}

class PointLoadedPlantState extends PointState {
  final List<Plant> plantList;

  PointLoadedPlantState(this.plantList);
}

class PointLoadedAnimalState extends PointState {
  final List<Animal> animalList;

  PointLoadedAnimalState(this.animalList);
}

class PointLoadedSoilState extends PointState {
  final List<Soil> soilList;

  PointLoadedSoilState(this.soilList);
}

class PointLoadedGroundState extends PointState {
  final List<Ground> groundList;

  PointLoadedGroundState(this.groundList);
}
