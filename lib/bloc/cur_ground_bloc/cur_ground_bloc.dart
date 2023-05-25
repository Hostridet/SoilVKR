import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../models/Ground.dart';
import '../../repository/GroundRepository.dart';

part 'cur_ground_event.dart';
part 'cur_ground_state.dart';

class CurGroundBloc extends Bloc<CurGroundEvent, CurGroundState> {
  GroundRepository _groundRepository;
  CurGroundBloc(this._groundRepository) : super(CurGroundInitial()) {
    on<CurGroundGetEvent>((event, emit) async {
      emit(CurGroundLoadingState());
      try {
        Ground ground = await _groundRepository.getCurrentGround(event.id);
        emit(CurGroundLoadedState(ground));
      }
      catch(e) {
        emit(CurGroundErrorState(e.toString()));
      }
    });
  }
}
