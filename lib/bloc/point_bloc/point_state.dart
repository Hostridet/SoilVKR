part of 'point_bloc.dart';

@immutable
abstract class PointState {}

class PointInitial extends PointState {}

class PointLoadedState extends PointState {
  final List<Point> pointList;

  PointLoadedState(this.pointList);
}

class PointErrorState extends PointState {
  final String error;

  PointErrorState(this.error);
}
