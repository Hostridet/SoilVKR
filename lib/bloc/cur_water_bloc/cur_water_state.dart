part of 'cur_water_bloc.dart';

@immutable
abstract class CurWaterState {}

class CurWaterInitial extends CurWaterState {}

class CurWaterLoadingState extends CurWaterState {}

class CurWaterLoadedState extends CurWaterState {
  final Water water;
  final bool isAdmin;

  CurWaterLoadedState(this.water, this.isAdmin);
}

class CurWaterErrorState extends CurWaterState {
  final String error;

  CurWaterErrorState(this.error);
}
