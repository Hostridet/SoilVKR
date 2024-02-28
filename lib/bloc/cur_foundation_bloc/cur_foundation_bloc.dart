import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:soil/models/Foundation.dart';
import 'package:soil/repository/AdminRepository.dart';
import 'package:soil/repository/FoundationRepository.dart';

part 'cur_foundation_event.dart';
part 'cur_foundation_state.dart';

class CurFoundationBloc extends Bloc<CurFoundationEvent, CurFoundationState> {
  FoundationRepository _foundationRepository;
  CurFoundationBloc(this._foundationRepository) : super(CurFoundationInitial()) {
    on<CurFoundationGetEvent>((event, emit) async {
      emit(CurFoundationLoadingState());
      try {
        Foundation animal = await _foundationRepository.getCurrentFoundation(event.id);
        bool isAdmin = await AdminRepository.isAdmin();
        emit(CurFoundationLoadedState(animal, isAdmin));
      } catch (e) {
        emit(CurFoundationErrorState(e.toString()));
      }
    });
  }
}
