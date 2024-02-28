import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:soil/models/Climat.dart';
import 'package:soil/repository/AdminRepository.dart';
import 'package:soil/repository/ClimatRepository.dart';

part 'cur_climat_event.dart';
part 'cur_climat_state.dart';

class CurClimatBloc extends Bloc<CurClimatEvent, CurClimatState> {
  ClimatRepository _climatRepository;
  CurClimatBloc(this._climatRepository) : super(CurClimatInitial()) {
    on<CurClimatGetEvent>((event, emit) async {
      emit(CurClimatLoadingState());
      try {
        Climat animal = await _climatRepository.getCurrentClimat(event.id);
        bool isAdmin = await AdminRepository.isAdmin();
        emit(CurClimatLoadedState(animal, isAdmin));
      } catch (e) {
        emit(CurClimatErrorState(e.toString()));
      }
    });
  }
}
