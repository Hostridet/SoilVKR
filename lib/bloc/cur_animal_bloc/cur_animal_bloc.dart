import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../models/Animal.dart';
import '../../repository/AnimalRepository.dart';

part 'cur_animal_event.dart';
part 'cur_animal_state.dart';

class CurAnimalBloc extends Bloc<CurAnimalEvent, CurAnimalState> {
  AnimalRepository _animalRepository;
  CurAnimalBloc(this._animalRepository) : super(CurAnimalInitial()) {
    on<CurAnimalGetEvent>((event, emit) async {
      try {
        Animal animal = await _animalRepository.getCurrentAnimal(event.id);
        emit(CurAnimalLoadedState(animal));
      }
      catch(e)  {
        emit(CurAnimalErrorState(e.toString()));
      }
    });
  }
}
