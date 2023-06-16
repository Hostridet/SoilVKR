part of 'cur_soil_bloc.dart';

@immutable
abstract class CurSoilState {}

class CurSoilInitial extends CurSoilState {}

class CurSoilLoadingState extends CurSoilState {}

class CurSoilLoadedState extends CurSoilState {
  final Soil soil;
  final bool isAdmin;

  CurSoilLoadedState(this.soil, this.isAdmin);
}

class CurSoilErrorState extends CurSoilState {
  final String error;

  CurSoilErrorState(this.error);
}
