import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:soil/models/Climat.dart';
import 'package:soil/models/Foundation.dart';
import 'package:soil/models/Point.dart';
import 'package:soil/models/PointClimat.dart';
import 'package:soil/models/PointFoundation.dart';
import 'package:soil/models/PointRelief.dart';
import 'package:soil/models/PointWater.dart';
import 'package:soil/models/Relief.dart';
import 'package:soil/models/Water.dart';
import 'package:soil/repository/ClimatRepository.dart';
import 'package:soil/repository/FoundationRepository.dart';
import 'package:soil/repository/GroundRepository.dart';
import 'package:soil/repository/PlantRepository.dart';
import 'package:soil/repository/PointRepository.dart';
import 'package:soil/repository/ReliefRepository.dart';
import 'package:soil/repository/WaterRepository.dart';

import '../../models/Animal.dart';
import '../../models/Ground.dart';
import '../../models/Plant.dart';
import '../../models/Soil.dart';
import '../../models/SoilGround.dart';
import '../../models/SoilPlant.dart';
import '../../models/SoilPoint.dart';
import '../../repository/AdminRepository.dart';
import '../../repository/SoilRepository.dart';

part 'soil_event.dart';
part 'soil_state.dart';

class SoilBloc extends Bloc<SoilEvent, SoilState> {
  final SoilRepository _soilRepository;
  SoilBloc(this._soilRepository) : super(SoilInitial()) {
    on<SoilGetEvent>((event, emit) async {
      emit(SoilLoadingState());
      try {
        List<Soil> soilList = await _soilRepository.getSoils();
        bool isAdmin = await AdminRepository.isAdmin();
        emit(SoilLoadedState(soilList, isAdmin));
      } catch (e) {
        emit(SoilErrorState(e.toString()));
      }
    });
    on<SoilViewUpdateEvent>((event, emit) async {
      emit(SoilViewUpdateState());
    });

    on<SoilUpdateEvent>((event, emit) async {
      await _soilRepository.insertSoil(event.name, event.description);
      add(SoilGetEvent());
    });

    on<SoilGetGroundConEvent>((event, emit) async {
      emit(SoilLoadingState());
      try {
        List<SoilGround> soilGroundList = await _soilRepository.getGroundCon();
        emit(SoilGroundConState(soilGroundList));
      } catch (e) {
        emit(SoilErrorState(e.toString()));
      }
    });

    on<SoilGetPlantConEvent>((event, emit) async {
      emit(SoilLoadingState());
      try {
        List<SoilPlant> soilPlantList = await _soilRepository.getPlantCon();
        emit(SoilPlantConState(soilPlantList));
      } catch (e) {
        emit(SoilErrorState(e.toString()));
      }
    });

    on<SoilGetPointConEvent>((event, emit) async {
      emit(SoilLoadingState());
      try {
        List<SoilPoint> soilPointList = await _soilRepository.getPointCon();
        emit(SoilPointConState(soilPointList));
      } catch (e) {
        emit(SoilErrorState(e.toString()));
      }
    });

    on<WaterGetPointConEvent>((event, emit) async {
      emit(SoilLoadingState());
      try {
        List<PointWater> soilPointList = await _soilRepository.getWaterPointCon();
        emit(WaterPointConState(soilPointList));
      } catch (e) {
        emit(SoilErrorState(e.toString()));
      }
    });

    on<ReliefGetPointConEvent>((event, emit) async {
      emit(SoilLoadingState());
      try {
        List<PointRelief> soilPointList = await _soilRepository.getReliefPointCon();
        emit(ReliefPointConState(soilPointList));
      } catch (e) {
        emit(SoilErrorState(e.toString()));
      }
    });

    on<ClimatGetPointConEvent>((event, emit) async {
      emit(SoilLoadingState());
      try {
        List<PointClimat> soilPointList = await _soilRepository.getClimatPointCon();
        emit(ClimatPointConState(soilPointList));
      } catch (e) {
        emit(SoilErrorState(e.toString()));
      }
    });

    on<FoundationGetPointConEvent>((event, emit) async {
      emit(SoilLoadingState());
      try {
        List<PointFoundation> soilPointList = await _soilRepository.getFoundationPointCon();
        emit(FoundationPointConState(soilPointList));
      } catch (e) {
        emit(SoilErrorState(e.toString()));
      }
    });

    on<SoilAddConGroundEvent>((event, emit) async {
      emit(SoilLoadingState());
      try {
        List<Soil> soilList = await _soilRepository.getSoils();
        GroundRepository repository = GroundRepository();
        List<Ground> groundList = await repository.getGround();
        emit(SoilAddConGroundState(soilList, groundList));
      } catch (e) {
        emit(SoilErrorState(e.toString()));
      }
    });

    on<SoilAddConPlantEvent>((event, emit) async {
      emit(SoilLoadingState());
      try {
        List<Soil> soilList = await _soilRepository.getSoils();
        PlantRepository repository = PlantRepository();
        List<Plant> plantList = await repository.getPlants();
        emit(SoilAddConPlantState(soilList, plantList));
      } catch (e) {
        emit(SoilErrorState(e.toString()));
      }
    });
    on<SoilAddConPointEvent>((event, emit) async {
      emit(SoilLoadingState());
      try {
        List<Soil> soilList = await _soilRepository.getSoils();
        PointRepository pointRepository = PointRepository();
        List<Point> pointList = await pointRepository.getAllPoints();
        emit(SoilAddPointState(soilList, pointList));
      } catch (e) {
        emit(SoilErrorState(e.toString()));
      }
    });

    on<WaterAddGetPointConEvent>((event, emit) async {
      emit(SoilLoadingState());
      try {
        WaterRepository waterRepository = WaterRepository();
        List<Water> soilList = await waterRepository.getWater();
        PointRepository pointRepository = PointRepository();
        List<Point> pointList = await pointRepository.getAllPoints();
        emit(WaterPointAddConState(soilList, pointList));
      } catch (e) {
        emit(SoilErrorState(e.toString()));
      }
    });

    on<ReliefAddGetPointConEvent>((event, emit) async {
      emit(SoilLoadingState());
      try {
        ReliefRepository waterRepository = ReliefRepository();
        List<Relief> soilList = await waterRepository.getRelief();
        PointRepository pointRepository = PointRepository();
        List<Point> pointList = await pointRepository.getAllPoints();
        emit(ReliefPointAddConState(soilList, pointList));
      } catch (e) {
        emit(SoilErrorState(e.toString()));
      }
    });

    on<FoundationAddGetPointConEvent>((event, emit) async {
      emit(SoilLoadingState());
      try {
        FoundationRepository waterRepository = FoundationRepository();
        List<Foundation> soilList = await waterRepository.getFoundation();
        PointRepository pointRepository = PointRepository();
        List<Point> pointList = await pointRepository.getAllPoints();
        emit(FoundationPointAddConState(soilList, pointList));
      } catch (e) {
        emit(SoilErrorState(e.toString()));
      }
    });

    on<ClimatAddGetPointConEvent>((event, emit) async {
      emit(SoilLoadingState());
      try {
        ClimatRepository waterRepository = ClimatRepository();
        List<Climat> soilList = await waterRepository.getCLimats();
        PointRepository pointRepository = PointRepository();
        List<Point> pointList = await pointRepository.getAllPoints();
        emit(ClimatPointAddConState(soilList, pointList));
      } catch (e) {
        emit(SoilErrorState(e.toString()));
      }
    });
  }
}
