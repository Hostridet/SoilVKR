part of 'cur_plant_bloc.dart';

@immutable
abstract class CurPlantEvent {}

class CurPlantGetEvent extends CurPlantEvent {
  final int id;

  CurPlantGetEvent(this.id);
}
