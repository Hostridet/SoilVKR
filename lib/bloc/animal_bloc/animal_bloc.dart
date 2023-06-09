import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../models/Animal.dart';
import '../../repository/AdminRepository.dart';
import '../../repository/AnimalRepository.dart';

part 'animal_event.dart';
part 'animal_state.dart';

class AnimalBloc extends Bloc<AnimalEvent, AnimalState> {
  AnimalRepository _animalRepository;
  AnimalBloc(this._animalRepository) : super(AnimalInitial()) {
    on<AnimalGetEvent>((event, emit) async {
      emit(AnimalLoadingState());
      try {
        List<Animal> animalList = await _animalRepository.getAnimals();
        bool isAdmin = await AdminRepository.isAdmin();
        emit(AnimalLoadedState(animalList, isAdmin));
      }
      catch(e) {
        emit(AnimalErrorState(e.toString()));
      }

    });
    on<AnimalViewUpdateEvent>((event, emit) async {
      emit(AnimalViewUpdateState());
    });

    on<AnimalUpdateEvent>((event, emit) async {
      await _animalRepository.insertAnimal(event.name, event.description);
      add(AnimalGetEvent());
    });
  }
}
