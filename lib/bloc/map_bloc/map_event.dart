part of 'map_bloc.dart';

@immutable
abstract class MapEvent {}

class MapGetEvent extends MapEvent {
  final double long;
  final double lat;

  MapGetEvent(this.long, this.lat);
}
