import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:soil/repository/AdminRepository.dart';

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
        bool isAdmin = await AdminRepository.isAdmin();
        emit(PlantLoadedState(plantList, isAdmin));
      }
      catch(e) {
        emit(PlantErrorState(e.toString()));
      }
    });

    on<PlantViewUpdateEvent>((event, emit) async {
      emit(PlantViewUpdateState());
    });

    on<PlantUpdateEvent>((event, emit) async {
      await _plantRepository.insertPlant(event.name, event.description, event.isFodder);
      add(PlantGetEvent());
    });

  }
}
