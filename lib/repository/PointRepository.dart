import '../models/Animal.dart';
import '../models/Ground.dart';
import '../models/Plant.dart';
import '../models/Point.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/Soil.dart';

class PointRepository {
  Future<List<Point>> getAllPoints() async {
    List<Point> pointList = [];
    final response = await http.get(Uri.parse("http://10.0.2.2:8080/territories/all"));
    if (response.statusCode == 200) {
      final data = await json.decode(utf8.decode(response.bodyBytes));
      for (dynamic item in data) {
        pointList.add(Point.fromJson(item));
      }
    }
    return pointList;
  }
  Future<Point> getPoint(int id) async {
    final response = await http.get(Uri.parse("http://10.0.2.2:8080/territories/one?territorie_id=$id"));
    final data = await json.decode(utf8.decode(response.bodyBytes));
    return Point.fromJson(data[0]);
  }

  Future<List<Animal>> getAnimalByPoint(int id) async {
    List<Animal> animalList = [];
    final response = await http.get(Uri.parse("http://10.0.2.2:8080/territories/byterritorieanimal?user_territorie_id=$id"));
    if (response.statusCode == 200) {
      final data = await json.decode(utf8.decode(response.bodyBytes));
      for (dynamic item in data) {
        animalList.add(Animal.fromJson(item));
      }
    }
    return animalList;
  }

  Future<List<Plant>> getPlantByPoint(int id) async {
    List<Plant> plantList = [];
    final response = await http.get(Uri.parse("http://10.0.2.2:8080/territories/byterritorieplant?user_territorie_id=$id"));
    if (response.statusCode == 200) {
      final data = await json.decode(utf8.decode(response.bodyBytes));
      for (dynamic item in data) {
        plantList.add(Plant.fromJson(item));
      }
    }
    return plantList;
  }

  Future<List<Soil>> getSoilByPoint(int id) async {
    List<Soil> soilList = [];
    final response = await http.get(Uri.parse("http://10.0.2.2:8080/territories/byterritoriesoil?user_territorie_id=$id"));
    if (response.statusCode == 200) {
      final data = await json.decode(utf8.decode(response.bodyBytes));
      for (dynamic item in data) {
        soilList.add(Soil.fromJson(item));
      }
    }
    return soilList;
  }

  Future<List<Ground>> getGroundByPoint(int id) async {
    List<Ground> groundList = [];
    final response = await http.get(Uri.parse("http://10.0.2.2:8080/territories/byterritorieground?user_territorie_id=$id"));
    if (response.statusCode == 200) {
      final data = await json.decode(utf8.decode(response.bodyBytes));
      for (dynamic item in data) {
        groundList.add(Ground.fromJson(item));
      }
    }
    return groundList;
  }
}