part of 'map_bloc.dart';

@immutable
abstract class MapEvent {}

class MapGetEvent extends MapEvent {
  final double long;
  final double lat;

  MapGetEvent(this.long, this.lat);
}

class MapUpdateEvent extends MapEvent {
  final int id;
  final String address;
  final double x;
  final double y;

  MapUpdateEvent(this.id, this.address, this.x, this.y);
}
