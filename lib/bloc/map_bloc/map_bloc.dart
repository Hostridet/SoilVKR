import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../repository/MapRepository.dart';

part 'map_event.dart';
part 'map_state.dart';

class MapBloc extends Bloc<MapEvent, MapState> {
  MapRepository _mapRepository;
  MapBloc(this._mapRepository) : super(MapInitial()) {
    on<MapGetEvent>((event, emit) async{
      int statusCode = await _mapRepository.getMapInfo(event.long, event.lat);
      if (statusCode == 200) {
        emit(MapSuccessState(event.long, event.lat));
      }
      else {
        emit(MapErrorState("Нет информации по локации"));
      }
    });
  }
}
