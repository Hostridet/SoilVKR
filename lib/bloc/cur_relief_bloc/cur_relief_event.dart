part of 'cur_relief_bloc.dart';

@immutable
abstract class CurReliefEvent {}

class CurReliefGetEvent extends CurReliefEvent {
  final int id;

  CurReliefGetEvent(this.id);
}
