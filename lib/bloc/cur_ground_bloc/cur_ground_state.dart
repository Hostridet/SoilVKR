part of 'cur_ground_bloc.dart';

@immutable
abstract class CurGroundState {}

class CurGroundInitial extends CurGroundState {}

class CurGroundLoadingState extends CurGroundState {}

class CurGroundLoadedState extends CurGroundState {
  final Ground ground;
  final bool isAdmin;

  CurGroundLoadedState(this.ground, this.isAdmin);
}

class CurGroundErrorState extends CurGroundState {
  final String error;

  CurGroundErrorState(this.error);
}

