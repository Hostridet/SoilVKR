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

class PointGetWaterEvent extends PointEvent {
  final int id;

  PointGetWaterEvent(this.id);
}

class PointGetClimatEvent extends PointEvent {
  final int id;

  PointGetClimatEvent(this.id);
}

class PointGetReliefEvent extends PointEvent {
  final int id;

  PointGetReliefEvent(this.id);
}

class PointGetFoundationEvent extends PointEvent {
  final int id;

  PointGetFoundationEvent(this.id);
}
