part of 'cur_soil_bloc.dart';

@immutable
abstract class CurSoilEvent {}

class CurSoilGetEvent extends CurSoilEvent {
  final int id;

  CurSoilGetEvent(this.id);
}
