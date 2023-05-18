part of 'zone_bloc.dart';

@immutable
abstract class ZoneState {}

class ZoneInitial extends ZoneState {}

class ZoneLoadingState extends ZoneState {}

class ZoneLoadedState extends ZoneState {
  final Zones zone;

  ZoneLoadedState(this.zone);
}

class ZoneErrorState extends ZoneState {
  final String error;

  ZoneErrorState(this.error);
}
