part of 'climat_bloc.dart';

@immutable
abstract class ClimatState {}

class ClimatInitial extends ClimatState {}

class ClimatLoadingState extends ClimatState {}

class ClimatLoadedState extends ClimatState {
  final List<Climat> climateList;
  final bool isAdmin;

  ClimatLoadedState(this.climateList, this.isAdmin);
}

class ClimatErrorState extends ClimatState {
  final String error;

  ClimatErrorState(this.error);
}

class ClimatViewUpdateState extends ClimatState {}
