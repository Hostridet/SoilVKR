import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../models/Soil.dart';
import '../../models/SoilGround.dart';
import '../../models/SoilPlant.dart';
import '../../models/SoilPoint.dart';
import '../../repository/AdminRepository.dart';
import '../../repository/SoilRepository.dart';

part 'soil_event.dart';
part 'soil_state.dart';

class SoilBloc extends Bloc<SoilEvent, SoilState> {
  final SoilRepository _soilRepository;
  SoilBloc(this._soilRepository) : super(SoilInitial()) {
    on<SoilGetEvent>((event, emit) async {
      emit(SoilLoadingState());
      try {
        List<Soil> soilList = await _soilRepository.getSoils();
        bool isAdmin = await AdminRepository.isAdmin();
        emit(SoilLoadedState(soilList, isAdmin));
      }
      catch(e) {
        emit(SoilErrorState(e.toString()));
      }
    });
    on<SoilViewUpdateEvent>((event, emit) async {
      emit(SoilViewUpdateState());
    });

    on<SoilUpdateEvent>((event, emit) async {
      await _soilRepository.insertSoil(event.name, event.description);
      add(SoilGetEvent());
    });

    on<SoilGetGroundConEvent>((event, emit) async {
      emit(SoilLoadingState());
      try {
        List<SoilGround> soilGroundList = await _soilRepository.getGroundCon();
        emit(SoilGroundConState(soilGroundList));
      }
      catch(e) {
        emit(SoilErrorState(e.toString()));
      }
    });

    on<SoilGetPlantConEvent>((event, emit) async {
      emit(SoilLoadingState());
      try {
        List<SoilPlant> soilPlantList = await _soilRepository.getPlantCon();
        emit(SoilPlantConState(soilPlantList));
      }
      catch(e) {
        emit(SoilErrorState(e.toString()));
      }
    });

    on<SoilGetPointConEvent>((event, emit) async {
      emit(SoilLoadingState());
      try {
        List<SoilPoint> soilPointList = await _soilRepository.getPointCon();
        emit(SoilPointConState(soilPointList));
      }
      catch(e) {
        emit(SoilErrorState(e.toString()));
      }
    });
  }
}
