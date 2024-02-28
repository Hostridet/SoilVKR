import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:soil/models/Relief.dart';
import 'package:soil/repository/AdminRepository.dart';
import 'package:soil/repository/ReliefRepository.dart';

part 'relief_event.dart';
part 'relief_state.dart';

class ReliefBloc extends Bloc<ReliefEvent, ReliefState> {
  ReliefRepository _reliefRepository;
  ReliefBloc(this._reliefRepository) : super(ReliefInitial()) {
    on<ReliefGetEvent>((event, emit) async {
      emit(ReliefLoadingState());
      try {
        List<Relief> animalList = await _reliefRepository.getRelief();
        bool isAdmin = await AdminRepository.isAdmin();
        emit(ReliefLoadedState(animalList, isAdmin));
      } catch (e) {
        emit(ReliefErrorState(e.toString()));
      }
    });
    on<ReliefViewUpdateEvent>((event, emit) async {
      emit(ReliefViewUpdateState());
    });

    on<ReliefUpdateEvent>((event, emit) async {
      await _reliefRepository.insertRelief(event.name, event.description);
      add(ReliefGetEvent());
    });
  }
}
