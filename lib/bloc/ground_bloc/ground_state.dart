part of 'ground_bloc.dart';

@immutable
abstract class GroundState {}

class GroundInitial extends GroundState {}

class GroundLoadingState extends GroundState {}

class GroundLoadedState extends GroundState {
  final List<Ground> groundList;

  GroundLoadedState(this.groundList);
}

class GroundErrorState extends GroundState {
  final String error;

  GroundErrorState(this.error);
}
