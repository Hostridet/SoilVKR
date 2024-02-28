part of 'cur_foundation_bloc.dart';

@immutable
abstract class CurFoundationState {}

class CurFoundationInitial extends CurFoundationState {}

class CurFoundationLoadingState extends CurFoundationState {}

class CurFoundationLoadedState extends CurFoundationState {
  final Foundation foundation;
  final bool isAdmin;

  CurFoundationLoadedState(this.foundation, this.isAdmin);
}

class CurFoundationErrorState extends CurFoundationState {
  final String error;

  CurFoundationErrorState(this.error);
}
