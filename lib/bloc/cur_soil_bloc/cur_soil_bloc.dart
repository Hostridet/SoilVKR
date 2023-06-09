import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../models/Soil.dart';
import '../../repository/SoilRepository.dart';

part 'cur_soil_event.dart';
part 'cur_soil_state.dart';

class CurSoilBloc extends Bloc<CurSoilEvent, CurSoilState> {
  SoilRepository _soilRepository;
  CurSoilBloc(this._soilRepository) : super(CurSoilInitial()) {
    on<CurSoilGetEvent>((event, emit) async {
      emit(CurSoilLoadingState());
      try {
        Soil soil = await _soilRepository.getCurrentSoil(event.id);
        emit(CurSoilLoadedState(soil));
      }
      catch(e) {
        emit(CurSoilErrorState(e.toString()));
      }
    });
  }
}
