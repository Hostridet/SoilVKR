part of 'relief_bloc.dart';

@immutable
abstract class ReliefState {}

class ReliefInitial extends ReliefState {}

class ReliefLoadingState extends ReliefState {}

class ReliefLoadedState extends ReliefState {
  final List<Relief> animalList;
  final bool isAdmin;

  ReliefLoadedState(this.animalList, this.isAdmin);
}

class ReliefErrorState extends ReliefState {
  final String error;

  ReliefErrorState(this.error);
}

class ReliefViewUpdateState extends ReliefState {}
