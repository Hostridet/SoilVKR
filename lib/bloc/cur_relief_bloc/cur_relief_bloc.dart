import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:soil/models/Relief.dart';
import 'package:soil/repository/AdminRepository.dart';
import 'package:soil/repository/ReliefRepository.dart';

part 'cur_relief_event.dart';
part 'cur_relief_state.dart';

class CurReliefBloc extends Bloc<CurReliefEvent, CurReliefState> {
  ReliefRepository _reliefRepository;
  CurReliefBloc(this._reliefRepository) : super(CurReliefInitial()) {
    on<CurReliefGetEvent>((event, emit) async {
      emit(CurReliefLoadingState());
      try {
        Relief animal = await _reliefRepository.getCurrentRelief(event.id);
        bool isAdmin = await AdminRepository.isAdmin();
        emit(CurReliefLoadedState(animal, isAdmin));
      } catch (e) {
        emit(CurReliefErrorState(e.toString()));
      }
    });
  }
}
