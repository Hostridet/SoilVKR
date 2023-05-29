part of 'map_bloc.dart';

@immutable
abstract class MapState {}

class MapInitial extends MapState {}

class MapSuccessState extends MapState {
  final double long;
  final double lat;

  MapSuccessState(this.long, this.lat);
}
class MapAdminState extends MapState {
  final bool isAdmin;

  MapAdminState(this.isAdmin);
}
class MapErrorState extends MapState {
  final String error;

  MapErrorState(this.error);
}
