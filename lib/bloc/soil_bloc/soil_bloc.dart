import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../models/Soil.dart';
import '../../repository/AdminRepository.dart';
import '../../repository/SoilRepository.dart';

part 'soil_event.dart';
part 'soil_state.dart';

class SoilBloc extends Bloc<SoilEvent, SoilState> {
  final SoilRepository _soilRepository;
  SoilBloc(this._soilRepository) : super(SoilInitial()) {
    on<SoilGetEvent>((event, emit) async {
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
  }
}
