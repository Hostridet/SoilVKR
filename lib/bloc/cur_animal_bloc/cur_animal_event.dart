part of 'cur_animal_bloc.dart';

@immutable
abstract class CurAnimalEvent {}

class CurAnimalGetEvent extends CurAnimalEvent {
  final int id;

  CurAnimalGetEvent(this.id);
}