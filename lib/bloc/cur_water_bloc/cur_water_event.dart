part of 'cur_water_bloc.dart';

@immutable
abstract class CurWaterEvent {}

class CurWaterGetEvent extends CurWaterEvent {
  final int id;

  CurWaterGetEvent(this.id);
}
