part of 'climat_bloc.dart';

@immutable
abstract class ClimatEvent {}

class ClimatGetEvent extends ClimatEvent {}

class ClimatViewUpdateEvent extends ClimatEvent {}

class ClimatUpdateEvent extends ClimatEvent {
  final String name;
  final String description;

  ClimatUpdateEvent(this.name, this.description);
}
