import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:soil/repository/AdminRepository.dart';
import '../../models/Animal.dart';
import '../../models/Ground.dart';
import '../../models/Plant.dart';
import '../../models/Point.dart';
import '../../models/Soil.dart';
import '../../repository/PointRepository.dart';

part 'point_event.dart';
part 'point_state.dart';

class PointBloc extends Bloc<PointEvent, PointState> {
  final PointRepository _pointRepository;
  PointBloc(this._pointRepository) : super(PointInitial()) {
    on<PointGetEvent>((event, emit) async {
      emit(PointLoadingState());
      try {
        List<Point> pointList = await _pointRepository.getAllPoints();
        bool isAdmin = await AdminRepository.isAdmin();
        emit(PointLoadedState(pointList, isAdmin));
      }
      catch(e) {
        emit(PointErrorState(e.toString()));
      }
    });

    on<PointGetOneEvent>((event, emit) async {
      emit(PointLoadingState());
      try {
        Point point = await _pointRepository.getPoint(event.id);
        emit(PointLoadedOneState(point));
      }
      catch(e) {
        emit(PointErrorState(e.toString()));
      }
    });

    on<PointGetPlantEvent>((event, emit) async {
      emit(PointLoadingState());
      try {
        List<Plant> plantList = await _pointRepository.getPlantByPoint(event.id);
        emit(PointLoadedPlantState(plantList));
      }
      catch(e) {
        emit(PointErrorState(e.toString()));
      }
    });

    on<PointGetAnimalEvent>((event, emit) async {
      emit(PointLoadingState());
      try {
        List<Animal> animalList = await _pointRepository.getAnimalByPoint(event.id);
        emit(PointLoadedAnimalState(animalList));
      }
      catch(e) {
        emit(PointErrorState(e.toString()));
      }
    });

    on<PointGetSoilEvent>((event, emit) async {
      emit(PointLoadingState());
      try {
        List<Soil> soilList = await _pointRepository.getSoilByPoint(event.id);
        emit(PointLoadedSoilState(soilList));
      }
      catch(e) {
        emit(PointErrorState(e.toString()));
      }
    });

    on<PointGetGroundEvent>((event, emit) async {
      emit(PointLoadingState());
      try {
        List<Ground> groundList = await _pointRepository.getGroundByPoint(event.id);
        emit(PointLoadedGroundState(groundList));
      }
      catch(e) {
        emit(PointErrorState(e.toString()));
      }
    });
  }
}
