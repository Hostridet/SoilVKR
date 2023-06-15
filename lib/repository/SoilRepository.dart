import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:soil/models/SoilPoint.dart';
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
  Future<void> insertSoil(String name, String description) async {
    final response = await http.post(Uri.parse("http://${Config.baseUrl}/soils/insert?soil_name=$name&soil_description=$description"));
  }
  static Future<int> insertConGround(int soilId, int groundId) async {
    int  statusCode = 404;
    final response = await http.post(Uri.parse("http://${Config.baseUrl}/connectionsoilsgrounds/insert?soil_id=$soilId&ground_id=$groundId"));
    statusCode = response.statusCode;
    return statusCode;
  }

  static Future<int> insertConPlant(int soilId, int plantId) async {
    int  statusCode = 404;
    final response = await http.post(Uri.parse("http://${Config.baseUrl}/connectionsoilsplants/insert?soil_id=$soilId&plant_id=$plantId"));
    statusCode = response.statusCode;
    return statusCode;
  }

  static Future<int> insertConPoint(int soilId, int pointId) async {
    int  statusCode = 404;
    final response = await http.post(Uri.parse("http://${Config.baseUrl}/connectionterritoriessoils/insert?territorie_id=$soilId&soil_id=$pointId"));
    statusCode = response.statusCode;
    return statusCode;
  }

  static Future<void> deleteSoil(int id) async {
    final response = await http.post(Uri.parse("http://${Config.baseUrl}/soils/delete?soil_id=$id"));
  }

  static Future<void> deleteConPoint(int id) async  {
    final response = await http.post(Uri.parse("http://${Config.baseUrl}/connectionterritoriessoils/delete?connection_territories_soils_id=$id"));

  }
  static Future<void> deleteConPlant(int id) async  {
    final response = await http.post(Uri.parse("http://${Config.baseUrl}/connectionsoilsplants/delete?connection_soils_plants_id=$id"));
  }
  static Future<void> deleteConGround(int id) async  {
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
}