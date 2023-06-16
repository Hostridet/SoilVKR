import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:soil/repository/AdminRepository.dart';

import '../../models/Plant.dart';
import '../../repository/PlantRepository.dart';

part 'cur_plant_event.dart';
part 'cur_plant_state.dart';

class CurPlantBloc extends Bloc<CurPlantEvent, CurPlantState> {
  PlantRepository _plantRepository;
  CurPlantBloc(this._plantRepository) : super(CurPlantInitial()) {
    on<CurPlantGetEvent>((event, emit) async {
      emit(CurPlantLoadingState());
      try {
        Plant plant = await _plantRepository.getCurrentPlant(event.id);
        bool isAdmin = await AdminRepository.isAdmin();
        emit(CurPlantLoadedState(plant, isAdmin));
      }
      catch(e) {
        emit(CurPlantErrorState(e.toString()));
      }
    });
  }
}
