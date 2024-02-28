import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:soil/models/Water.dart';
import 'package:soil/repository/AdminRepository.dart';
import 'package:soil/repository/WaterRepository.dart';

part 'cur_water_event.dart';
part 'cur_water_state.dart';

class CurWaterBloc extends Bloc<CurWaterEvent, CurWaterState> {
  WaterRepository _waterRepository;
  CurWaterBloc(this._waterRepository) : super(CurWaterInitial()) {
    on<CurWaterGetEvent>((event, emit) async {
      emit(CurWaterLoadingState());
      try {
        Water animal = await _waterRepository.getCurrentWater(event.id);
        bool isAdmin = await AdminRepository.isAdmin();
        emit(CurWaterLoadedState(animal, isAdmin));
      } catch (e) {
        emit(CurWaterErrorState(e.toString()));
      }
    });
  }
}
