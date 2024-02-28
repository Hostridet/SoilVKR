import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:soil/models/Water.dart';
import 'package:soil/repository/AdminRepository.dart';
import 'package:soil/repository/WaterRepository.dart';

part 'water_event.dart';
part 'water_state.dart';

class WaterBloc extends Bloc<WaterEvent, WaterState> {
  WaterRepository _waterRepository;
  WaterBloc(this._waterRepository) : super(WaterInitial()) {
    on<WaterGetEvent>((event, emit) async {
      emit(WaterLoadingState());
      try {
        List<Water> animalList = await _waterRepository.getWater();
        bool isAdmin = await AdminRepository.isAdmin();
        emit(WaterLoadedState(animalList, isAdmin));
      } catch (e) {
        emit(WaterErrorState(e.toString()));
      }
    });
    on<WaterViewUpdateEvent>((event, emit) async {
      emit(WaterViewUpdateState());
    });

    on<WaterUpdateEvent>((event, emit) async {
      await _waterRepository.insertWater(event.name, event.description);
      add(WaterGetEvent());
    });
  }
}
