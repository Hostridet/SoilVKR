part of 'cur_climat_bloc.dart';

@immutable
abstract class CurClimatEvent {}

class CurClimatGetEvent extends CurClimatEvent {
  final int id;

  CurClimatGetEvent(this.id);
}
