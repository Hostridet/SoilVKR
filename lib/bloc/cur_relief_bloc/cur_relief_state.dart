part of 'cur_relief_bloc.dart';

@immutable
abstract class CurReliefState {}

class CurReliefInitial extends CurReliefState {}

class CurReliefLoadingState extends CurReliefState {}

class CurReliefLoadedState extends CurReliefState {
  final Relief relief;
  final bool isAdmin;

  CurReliefLoadedState(this.relief, this.isAdmin);
}

class CurReliefErrorState extends CurReliefState {
  final String error;

  CurReliefErrorState(this.error);
}
