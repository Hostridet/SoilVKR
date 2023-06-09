import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../models/Ground.dart';
import '../../repository/AdminRepository.dart';
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
        bool isAdmin = await AdminRepository.isAdmin();
        emit(GroundLoadedState(groundList, isAdmin));
      }
      catch(e) {
        emit(GroundErrorState(e.toString()));
      }
    });
    on<GroundViewUpdateEvent>((event, emit) async {
      emit(GroundViewUpdateState());
    });

    on<GroundUpdateEvent>((event, emit) async {
      await _groundRepository.insertGround(event.name, event.description);
      add(GroundGetEvent());
    });
  }
}
