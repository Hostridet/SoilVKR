import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:soil/repository/AdminRepository.dart';
import '../../models/Point.dart';
import '../../repository/MapRepository.dart';

part 'map_event.dart';
part 'map_state.dart';

class MapBloc extends Bloc<MapEvent, MapState> {
  MapRepository _mapRepository;
  MapBloc(this._mapRepository) : super(MapInitial()) {
    on<MapGetEvent>((event, emit) async{
      List<dynamic> requestBody = await _mapRepository.getMapInfo(event.long, event.lat);
      if (requestBody[1] == 200) {
        emit(MapSuccessState(requestBody[0]));
      }
      else {
        emit(MapErrorState("Нет информации по локации"));
      }
    });
    on<MapIsAdmin>((event, emit) async{
      bool isAdmin = await AdminRepository.isAdmin();
      emit(MapAdminState(isAdmin));
    });

    on<MapUpdateEvent>((event, emit) async{
      try {
        _mapRepository.updateMapInfo(event.id, event.address, event.x, event.y);
      }
      catch(e) {
        emit(MapErrorState(e.toString()));
      }
    });
    on<MapAddEvent>((event, emit) async{
      try {
        _mapRepository.addPoint(event.x, event.y, event.address);
      }
      catch(e) {
        emit(MapErrorState(e.toString()));
      }
    });
  }
}
