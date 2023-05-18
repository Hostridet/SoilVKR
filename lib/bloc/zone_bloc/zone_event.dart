part of 'zone_bloc.dart';

@immutable
abstract class ZoneEvent {}

class ZoneGetEvent extends ZoneEvent {
  final double long;
  final double lat;

  ZoneGetEvent(this.long, this.lat);
}
