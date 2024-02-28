import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:soil/models/Climat.dart';
import 'package:soil/repository/AdminRepository.dart';
import 'package:soil/repository/ClimatRepository.dart';

part 'climat_event.dart';
part 'climat_state.dart';

class ClimatBloc extends Bloc<ClimatEvent, ClimatState> {
  ClimatRepository _climatRepository;
  ClimatBloc(this._climatRepository) : super(ClimatInitial()) {
    on<ClimatGetEvent>((event, emit) async {
      emit(ClimatLoadingState());
      try {
        List<Climat> animalList = await _climatRepository.getCLimats();
        bool isAdmin = await AdminRepository.isAdmin();
        emit(ClimatLoadedState(animalList, isAdmin));
      } catch (e) {
        emit(ClimatErrorState(e.toString()));
      }
    });
    on<ClimatViewUpdateEvent>((event, emit) async {
      emit(ClimatViewUpdateState());
    });

    on<ClimatUpdateEvent>((event, emit) async {
      await _climatRepository.insertClimat(event.name, event.description);
      add(ClimatGetEvent());
    });
  }
}
