part of 'foundation_bloc.dart';

@immutable
abstract class FoundationState {}

class FoundationInitial extends FoundationState {}

class FoundationLoadingState extends FoundationState {}

class FoundationLoadedState extends FoundationState {
  final List<Foundation> animalList;
  final bool isAdmin;

  FoundationLoadedState(this.animalList, this.isAdmin);
}

class FoundationErrorState extends FoundationState {
  final String error;

  FoundationErrorState(this.error);
}

class FoundationViewUpdateState extends FoundationState {}
