import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../models/Ground.dart';
import '../../repository/GroundRepository.dart';

part 'ground_event.dart';
part 'ground_state.dart';

class GroundBloc extends Bloc<GroundEvent, GroundState> {
  final GroundRepository _groundRepository;
  GroundBloc(this._groundRepository) : super(GroundInitial()) {
    on<GroundGetEvent>((event, emit) async {
      emit(GroundLoadingState());
      try {
        List<Ground> groundList = await _groundRepository.getGround();
        emit(GroundLoadedState(groundList));
      }
      catch(e) {
        emit(GroundErrorState(e.toString()));
      }
    });
  }
}
