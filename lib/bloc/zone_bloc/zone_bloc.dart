import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../models/Zone.dart';
import '../../repository/ZoneRepository.dart';

part 'zone_event.dart';
part 'zone_state.dart';

class ZoneBloc extends Bloc<ZoneEvent, ZoneState> {
  ZoneRepository _repository;
  ZoneBloc(this._repository) : super(ZoneInitial()) {
    on<ZoneGetEvent>((event, emit) async {
      try {
        Zones zone = await _repository.getZoneInfo(event.long, event.lat);
        emit(ZoneLoadedState(zone));
      }
      catch(e) {
        emit(ZoneErrorState(e.toString()));
      }
    });
  }
}
