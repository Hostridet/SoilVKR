part of 'cur_climat_bloc.dart';

@immutable
abstract class CurClimatState {}

class CurClimatInitial extends CurClimatState {}

class CurClimatLoadingState extends CurClimatState {}

class CurClimatLoadedState extends CurClimatState {
  final Climat climat;
  final bool isAdmin;

  CurClimatLoadedState(this.climat, this.isAdmin);
}

class CurClimatErrorState extends CurClimatState {
  final String error;

  CurClimatErrorState(this.error);
}
