part of 'foundation_bloc.dart';

@immutable
abstract class FoundationEvent {}

class FoundationGetEvent extends FoundationEvent {}

class FoundationViewUpdateEvent extends FoundationEvent {}

class FoundationUpdateEvent extends FoundationEvent {
  final String name;
  final String description;

  FoundationUpdateEvent(this.name, this.description);
}
