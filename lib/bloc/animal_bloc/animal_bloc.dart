import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../models/Animal.dart';
import '../../repository/AnimalRepository.dart';

part 'animal_event.dart';
part 'animal_state.dart';

class AnimalBloc extends Bloc<AnimalEvent, AnimalState> {
  AnimalRepository _animalRepository;
  AnimalBloc(this._animalRepository) : super(AnimalInitial()) {
    on<AnimalEvent>((event, emit) async {
      try {
        List<Animal> animalList = await _animalRepository.getAnimals();
        emit(AnimalLoadedState(animalList));
      }
      catch(e) {
        emit(AnimalErrorState(e.toString()));
      }

    });
  }
}
