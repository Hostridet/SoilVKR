import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../models/Plant.dart';
import '../../repository/PlantRepository.dart';

part 'plant_event.dart';
part 'plant_state.dart';

class PlantBloc extends Bloc<PlantEvent, PlantState> {
  PlantRepository _plantRepository;
  PlantBloc(this._plantRepository) : super(PlantInitial()) {
    on<PlantGetEvent>((event, emit) async {
      try {
        List<Plant> plantList = await _plantRepository.getPlants();
        emit(PlantLoadedState(plantList));
      }
      catch(e) {
        emit(PlantErrorState(e.toString()));
      }
    });
  }
}
