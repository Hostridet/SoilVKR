import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import '../../models/Point.dart';
import '../../repository/PointRepository.dart';

part 'point_event.dart';
part 'point_state.dart';

class PointBloc extends Bloc<PointEvent, PointState> {
  final PointRepository _pointRepository;
  PointBloc(this._pointRepository) : super(PointInitial()) {
    on<PointGetEvent>((event, emit) async {
      try {
        List<Point> pointList = await _pointRepository.getAllPoints();
        emit(PointLoadedState(pointList));
      }
      catch(e) {
        emit(PointErrorState(e.toString()));
      }
    });
  }
}
