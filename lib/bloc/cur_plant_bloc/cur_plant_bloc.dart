import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../models/Plant.dart';
import '../../repository/PlantRepository.dart';

part 'cur_plant_event.dart';
part 'cur_plant_state.dart';

class CurPlantBloc extends Bloc<CurPlantEvent, CurPlantState> {
  PlantRepository _plantRepository;
  CurPlantBloc(this._plantRepository) : super(CurPlantInitial()) {
    on<CurPlantGetEvent>((event, emit) async {
      try {
        Plant plant = await _plantRepository.getCurrentPlant(event.id);
        emit(CurPlantLoadedState(plant));
      }
      catch(e) {
        emit(CurPlantErrorState(e.toString()));
      }
    });
  }
}
