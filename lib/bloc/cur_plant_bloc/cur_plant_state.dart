part of 'cur_plant_bloc.dart';

@immutable
abstract class CurPlantState {}

class CurPlantInitial extends CurPlantState {}

class CurPlantLoadingState extends CurPlantState {}

class CurPlantLoadedState extends CurPlantState {
  final Plant plant;
  final bool isAdmin;

  CurPlantLoadedState(this.plant, this.isAdmin);
}

class CurPlantErrorState extends CurPlantState {
  final String error;

  CurPlantErrorState(this.error);
}