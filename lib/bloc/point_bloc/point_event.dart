part of 'point_bloc.dart';

@immutable
abstract class PointEvent {}

class PointGetEvent extends PointEvent {}

class PointGetOneEvent extends PointEvent {
  final int id;

  PointGetOneEvent(this.id);
}

class PointGetPlantEvent extends PointEvent {
  final int id;

  PointGetPlantEvent(this.id);
}

class PointGetAnimalEvent extends PointEvent {
  final int id;

  PointGetAnimalEvent(this.id);
}

class PointGetSoilEvent extends PointEvent {
  final int id;

  PointGetSoilEvent(this.id);
}

class PointGetGroundEvent extends PointEvent {
  final int id;

  PointGetGroundEvent(this.id);
}
