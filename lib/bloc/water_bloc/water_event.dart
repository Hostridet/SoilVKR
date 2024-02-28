part of 'water_bloc.dart';

@immutable
abstract class WaterEvent {}

class WaterGetEvent extends WaterEvent {}

class WaterViewUpdateEvent extends WaterEvent {}

class WaterUpdateEvent extends WaterEvent {
  final String name;
  final String description;

  WaterUpdateEvent(this.name, this.description);
}
