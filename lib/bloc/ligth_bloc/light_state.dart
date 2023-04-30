part of 'light_bloc.dart';

@immutable
abstract class LightState {}

class LightInitial extends LightState {}

class LightLoadedState extends LightState {
  bool light;

  LightLoadedState(this.light);
}
