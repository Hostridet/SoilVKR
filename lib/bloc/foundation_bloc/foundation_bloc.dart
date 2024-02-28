import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:soil/models/Foundation.dart';
import 'package:soil/repository/AdminRepository.dart';
import 'package:soil/repository/FoundationRepository.dart';

part 'foundation_event.dart';
part 'foundation_state.dart';

class FoundationBloc extends Bloc<FoundationEvent, FoundationState> {
  FoundationRepository _foundationRepository;
  FoundationBloc(this._foundationRepository) : super(FoundationInitial()) {
    on<FoundationGetEvent>((event, emit) async {
      emit(FoundationLoadingState());
      try {
        List<Foundation> animalList = await _foundationRepository.getFoundation();
        bool isAdmin = await AdminRepository.isAdmin();
        emit(FoundationLoadedState(animalList, isAdmin));
      } catch (e) {
        emit(FoundationErrorState(e.toString()));
      }
    });
    on<FoundationViewUpdateEvent>((event, emit) async {
      emit(FoundationViewUpdateState());
    });

    on<FoundationUpdateEvent>((event, emit) async {
      await _foundationRepository.insertFoundation(event.name, event.description);
      add(FoundationGetEvent());
    });
  }
}
