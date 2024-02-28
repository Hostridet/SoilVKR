import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:soil/models/Climat.dart';
import 'package:soil/models/Foundation.dart';
import 'package:soil/models/PointClimat.dart';
import 'package:soil/models/PointFoundation.dart';
import 'package:soil/models/PointRelief.dart';
import 'package:soil/models/PointWater.dart';
import 'package:soil/models/Relief.dart';
import 'package:soil/models/SoilPoint.dart';
import 'package:soil/models/Water.dart';
import 'package:soil/repository/PlantRepository.dart';
import 'package:soil/repository/PointRepository.dart';
import '../config.dart';
import '../models/Ground.dart';
import '../models/Point.dart';
import '../models/Plant.dart';
import '../models/Soil.dart';
import '../models/SoilGround.dart';
import '../models/SoilPlant.dart';
import 'GroundRepository.dart';

class SoilRepository {
  Future<List<Soil>> getSoils() async {
    List<Soil> soilList = [];
    final response = await http.get(Uri.parse("http://${Config.baseUrl}/soils/all"));
    if (response.statusCode == 200) {
      final data = await json.decode(utf8.decode(response.bodyBytes));
      for (dynamic item in data) {
        soilList.add(Soil.fromJson(item));
      }
    }
    return soilList;
  }

  Future<Soil> getCurrentSoil(int id) async {
    final response = await http.get(Uri.parse("http://${Config.baseUrl}/soils/one?soil_id=$id"));
    final data = await json.decode(utf8.decode(response.bodyBytes));
    Soil soil = Soil.fromJson(data[0]);
    return soil;
  }

  Future<Water> getCurrentWater(int id) async {
    final response = await http.get(Uri.parse("http://${Config.baseUrl}/waters/one?water_id=$id"));
    final data = await json.decode(utf8.decode(response.bodyBytes));
    Water soil = Water.fromJson(data[0]);
    return soil;
  }

  Future<Relief> getCurrentRelief(int id) async {
    final response = await http.get(Uri.parse("http://${Config.baseUrl}/reliefs/one?relief_id=$id"));
    final data = await json.decode(utf8.decode(response.bodyBytes));
    Relief soil = Relief.fromJson(data[0]);
    return soil;
  }

  Future<Climat> getCurrentClimat(int id) async {
    final response = await http.get(Uri.parse("http://${Config.baseUrl}/climats/one?climat_id=$id"));
    final data = await json.decode(utf8.decode(response.bodyBytes));
    Climat soil = Climat.fromJson(data[0]);
    return soil;
  }

  Future<Foundation> getCurrentFoundation(int id) async {
    final response = await http.get(Uri.parse("http://${Config.baseUrl}/foundations/one?foundation_id=$id"));
    final data = await json.decode(utf8.decode(response.bodyBytes));
    Foundation soil = Foundation.fromJson(data[0]);
    return soil;
  }

  Future<void> insertSoil(String name, String description) async {
    final response = await http.post(Uri.parse("http://${Config.baseUrl}/soils/insert?soil_name=$name&soil_description=$description"));
  }

  static Future<int> insertConGround(int soilId, int groundId) async {
    int statusCode = 404;
    final response =
        await http.post(Uri.parse("http://${Config.baseUrl}/connectionsoilsgrounds/insert?soil_id=$soilId&ground_id=$groundId"));
    statusCode = response.statusCode;
    return statusCode;
  }

  static Future<int> insertConPlant(int soilId, int plantId) async {
    int statusCode = 404;
    final response = await http.post(Uri.parse("http://${Config.baseUrl}/connectionsoilsplants/insert?soil_id=$soilId&plant_id=$plantId"));
    statusCode = response.statusCode;
    return statusCode;
  }

  static Future<int> insertConPoint(int soilId, int pointId) async {
    int statusCode = 404;
    final response =
        await http.post(Uri.parse("http://${Config.baseUrl}/connectionterritoriessoils/insert?territorie_id=$pointId&soil_id=$soilId"));
    statusCode = response.statusCode;
    return statusCode;
  }

  static Future<int> insertConClimat(int soilId, int pointId) async {
    int statusCode = 404;
    final response =
        await http.post(Uri.parse("http://${Config.baseUrl}/connectionterritoriesclimats/insert?territorie_id=$pointId&climat_id=$soilId"));
    statusCode = response.statusCode;
    return statusCode;
  }

  static Future<int> insertConWater(int soilId, int pointId) async {
    int statusCode = 404;
    final response =
        await http.post(Uri.parse("http://${Config.baseUrl}/connectionterritorieswaters/insert?territorie_id=$pointId&water_id=$soilId"));
    statusCode = response.statusCode;
    return statusCode;
  }

  static Future<int> insertConFoundation(int soilId, int pointId) async {
    int statusCode = 404;
    final response = await http
        .post(Uri.parse("http://${Config.baseUrl}/connectionterritoriesfoundations/insert?territorie_id=$pointId&foundation_id=$soilId"));
    statusCode = response.statusCode;
    return statusCode;
  }

  static Future<int> insertConRelief(int soilId, int pointId) async {
    int statusCode = 404;
    final response =
        await http.post(Uri.parse("http://${Config.baseUrl}/connectionterritoriesreliefs/insert?territorie_id=$pointId&relief_id=$soilId"));
    statusCode = response.statusCode;
    return statusCode;
  }

  static Future<void> deleteSoil(int id) async {
    final response = await http.post(Uri.parse("http://${Config.baseUrl}/soils/delete?soil_id=$id"));
  }

  static Future<void> deleteConPoint(int id) async {
    final response =
        await http.post(Uri.parse("http://${Config.baseUrl}/connectionterritoriessoils/delete?connection_territories_soils_id=$id"));
  }

  static Future<void> deleteConPlant(int id) async {
    final response = await http.post(Uri.parse("http://${Config.baseUrl}/connectionsoilsplants/delete?connection_soils_plants_id=$id"));
  }

  static Future<void> deleteConGround(int id) async {
    final response = await http.post(Uri.parse("http://${Config.baseUrl}/connectionsoilsgrounds/delete?connection_soils_grounds_id=$id"));
  }

  Future<List<SoilGround>> getGroundCon() async {
    List<SoilGround> soilGroundList = [];
    final response = await http.get(Uri.parse("http://${Config.baseUrl}/connectionsoilsgrounds/all"));
    if (response.statusCode == 200) {
      final data = await json.decode(utf8.decode(response.bodyBytes));
      for (dynamic item in data) {
        Soil soil = await getCurrentSoil(item['soil_id']);
        GroundRepository groundRepository = GroundRepository();
        Ground ground = await groundRepository.getCurrentGround(item['ground_id']);
        soilGroundList.add(SoilGround(id: item['connection_soils_grounds_id'], soil: soil, ground: ground));
      }
    }
    return soilGroundList;
  }

  Future<List<SoilGround>> getLocationClimatCon() async {
    List<SoilGround> soilGroundList = [];
    final response = await http.get(Uri.parse("http://${Config.baseUrl}/connectionsoilsgrounds/all"));
    if (response.statusCode == 200) {
      final data = await json.decode(utf8.decode(response.bodyBytes));
      for (dynamic item in data) {
        Soil soil = await getCurrentSoil(item['soil_id']);
        GroundRepository groundRepository = GroundRepository();
        Ground ground = await groundRepository.getCurrentGround(item['ground_id']);
        soilGroundList.add(SoilGround(id: item['connection_soils_grounds_id'], soil: soil, ground: ground));
      }
    }
    return soilGroundList;
  }

  Future<List<SoilPlant>> getPlantCon() async {
    List<SoilPlant> soilPlantList = [];
    final response = await http.get(Uri.parse("http://${Config.baseUrl}/connectionsoilsplants/all"));
    if (response.statusCode == 200) {
      final data = await json.decode(utf8.decode(response.bodyBytes));
      for (dynamic item in data) {
        Soil soil = await getCurrentSoil(item['soil_id']);
        PlantRepository plantRepository = PlantRepository();
        Plant plant = await plantRepository.getCurrentPlant(item['plant_id']);
        soilPlantList.add(SoilPlant(id: item['connection_soils_plants_id'], soil: soil, plant: plant));
      }
    }
    return soilPlantList;
  }

  Future<List<SoilPoint>> getPointCon() async {
    List<SoilPoint> soilPointList = [];
    final response = await http.get(Uri.parse("http://${Config.baseUrl}/connectionterritoriessoils/all"));
    if (response.statusCode == 200) {
      final data = await json.decode(utf8.decode(response.bodyBytes));
      for (dynamic item in data) {
        Soil soil = await getCurrentSoil(item['soil_id']);
        PointRepository plantRepository = PointRepository();
        Point point = await plantRepository.getPoint(item['territorie_id']);
        soilPointList.add(SoilPoint(id: item['connection_territories_soils_id'], soil: soil, point: point));
      }
    }
    return soilPointList;
  }

  Future<List<PointWater>> getWaterPointCon() async {
    List<PointWater> soilPointList = [];
    final response = await http.get(Uri.parse("http://${Config.baseUrl}/connectionterritorieswaters/all"));
    if (response.statusCode == 200) {
      final data = await json.decode(utf8.decode(response.bodyBytes));
      for (dynamic item in data) {
        Water water = await getCurrentWater(item['water_id']);
        PointRepository plantRepository = PointRepository();
        Point point = await plantRepository.getPoint(item['territorie_id']);
        soilPointList.add(PointWater(id: item['connection_territories_waters_id'], water: water, point: point));
      }
    }
    return soilPointList;
  }

  Future<List<PointRelief>> getReliefPointCon() async {
    List<PointRelief> soilPointList = [];
    final response = await http.get(Uri.parse("http://${Config.baseUrl}/connectionterritoriesreliefs/all"));
    if (response.statusCode == 200) {
      final data = await json.decode(utf8.decode(response.bodyBytes));
      for (dynamic item in data) {
        Relief relief = await getCurrentRelief(item['relief_id']);
        PointRepository plantRepository = PointRepository();
        Point point = await plantRepository.getPoint(item['territorie_id']);
        soilPointList.add(PointRelief(id: item['connection_territories_reliefs_id'], relief: relief, point: point));
      }
    }
    return soilPointList;
  }

  Future<List<PointClimat>> getClimatPointCon() async {
    List<PointClimat> soilPointList = [];
    final response = await http.get(Uri.parse("http://${Config.baseUrl}/connectionterritoriesclimats/all"));
    if (response.statusCode == 200) {
      final data = await json.decode(utf8.decode(response.bodyBytes));
      for (dynamic item in data) {
        Climat relief = await getCurrentClimat(item['climat_id']);
        PointRepository plantRepository = PointRepository();
        Point point = await plantRepository.getPoint(item['territorie_id']);
        soilPointList.add(PointClimat(id: item['connection_territories_climats_id'], climat: relief, point: point));
      }
    }
    return soilPointList;
  }

  Future<List<PointFoundation>> getFoundationPointCon() async {
    List<PointFoundation> soilPointList = [];
    final response = await http.get(Uri.parse("http://${Config.baseUrl}/connectionterritoriesfoundations/all"));
    if (response.statusCode == 200) {
      final data = await json.decode(utf8.decode(response.bodyBytes));
      for (dynamic item in data) {
        Foundation relief = await getCurrentFoundation(item['foundation_id']);
        PointRepository plantRepository = PointRepository();
        Point point = await plantRepository.getPoint(item['territorie_id']);
        soilPointList.add(PointFoundation(id: item['connection_territories_foundations_id'], foundation: relief, point: point));
      }
    }
    return soilPointList;
  }

  static Future<int> updateName(int id, String value) async {
    int statusCode = 400;
    final response = await http.post(Uri.parse("http://${Config.baseUrl}/soils/update/name?soil_id=$id&soil_name=$value"));
    statusCode = response.statusCode;
    return statusCode;
  }

  static Future<int> updateDescription(int id, String value) async {
    int statusCode = 400;
    final response = await http.post(Uri.parse("http://${Config.baseUrl}/soils/update/description?soil_id=$id&soil_description=$value"));
    statusCode = response.statusCode;
    return statusCode;
  }

  static Future<int> updateAcidity(int id, String value) async {
    int statusCode = 400;
    final response =
        await http.post(Uri.parse("http://${Config.baseUrl}/soils/update/acidity?soil_id=$id&soil_acidity=${int.parse(value)}"));
    statusCode = response.statusCode;
    return statusCode;
  }

  static Future<int> updateMinerals(int id, String value) async {
    int statusCode = 400;
    final response = await http.post(Uri.parse("http://${Config.baseUrl}/soils/update/minerals?soil_id=$id&soil_minerals=$value"));
    statusCode = response.statusCode;
    return statusCode;
  }

  static Future<int> updateProfile(int id, String value) async {
    int statusCode = 400;
    final response = await http.post(Uri.parse("http://${Config.baseUrl}/soils/update/profile?soil_id=$id&soil_profile=$value"));
    statusCode = response.statusCode;
    return statusCode;
  }
}
