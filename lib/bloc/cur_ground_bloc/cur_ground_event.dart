part of 'cur_ground_bloc.dart';

@immutable
abstract class CurGroundEvent {}

class CurGroundGetEvent extends CurGroundEvent {
  final int id;

  CurGroundGetEvent(this.id);
}
