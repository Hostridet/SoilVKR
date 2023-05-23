part of 'cur_animal_bloc.dart';

@immutable
abstract class CurAnimalState {}

class CurAnimalInitial extends CurAnimalState {}

class CurAnimalLoadingState extends CurAnimalState {}

class CurAnimalLoadedState extends CurAnimalState {
  final Animal animal;

  CurAnimalLoadedState(this.animal);
}

class CurAnimalErrorState extends CurAnimalState {
  final String error;

  CurAnimalErrorState(this.error);
}
