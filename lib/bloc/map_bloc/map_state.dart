part of 'map_bloc.dart';

@immutable
abstract class MapState {}

class MapInitial extends MapState {}

class MapSuccessState extends MapState {
  final Point point;

  MapSuccessState(this.point);
}
class MapAdminState extends MapState {
  final bool isAdmin;

  MapAdminState(this.isAdmin);
}
class MapErrorState extends MapState {
  final String error;

  MapErrorState(this.error);
}
