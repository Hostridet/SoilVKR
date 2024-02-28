import 'package:soil/models/Climat.dart';
import 'package:soil/models/Foundation.dart';
import 'package:soil/models/Relief.dart';
import 'package:soil/models/Water.dart';

import '../config.dart';
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
    final response = await http.get(Uri.parse("http://${Config.baseUrl}/territories/all"));
    if (response.statusCode == 200) {
      final data = await json.decode(utf8.decode(response.bodyBytes));
      for (dynamic item in data) {
        pointList.add(Point.fromJson(item));
      }
    }
    return pointList;
  }

  Future<Point> getPoint(int id) async {
    final response = await http.get(Uri.parse("http://${Config.baseUrl}/territories/one?territorie_id=$id"));
    final data = await json.decode(utf8.decode(response.bodyBytes));
    return Point.fromJson(data[0]);
  }

  Future<List<Animal>> getAnimalByPoint(int id) async {
    List<Animal> animalList = [];
    final response = await http.get(Uri.parse("http://${Config.baseUrl}/territories/byterritorieanimal?user_territorie_id=$id"));
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
    final response = await http.get(Uri.parse("http://${Config.baseUrl}/territories/byterritorieplant?user_territorie_id=$id"));
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
    final response = await http.get(Uri.parse("http://${Config.baseUrl}/territories/byterritoriesoils?user_territorie_id=$id"));
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
    final response = await http.get(Uri.parse("http://${Config.baseUrl}/territories/byterritorieground?user_territorie_id=$id"));
    if (response.statusCode == 200) {
      final data = await json.decode(utf8.decode(response.bodyBytes));
      for (dynamic item in data) {
        groundList.add(Ground.fromJson(item));
      }
    }
    return groundList;
  }

  Future<List<Water>> getWaterByPoint(int id) async {
    List<Water> groundList = [];
    final response = await http.get(Uri.parse("http://${Config.baseUrl}/territories/byterritoriewaters?user_territorie_id=$id"));
    if (response.statusCode == 200) {
      final data = await json.decode(utf8.decode(response.bodyBytes));
      for (dynamic item in data) {
        groundList.add(Water.fromJson(item));
      }
    }
    return groundList;
  }

  Future<List<Relief>> getReliefByPoint(int id) async {
    List<Relief> groundList = [];
    final response = await http.get(Uri.parse("http://${Config.baseUrl}/territories/byterritoriereliefs?user_territorie_id=$id"));
    if (response.statusCode == 200) {
      final data = await json.decode(utf8.decode(response.bodyBytes));
      for (dynamic item in data) {
        groundList.add(Relief.fromJson(item));
      }
    }
    return groundList;
  }

  Future<List<Climat>> getClimatByPoint(int id) async {
    List<Climat> groundList = [];
    final response = await http.get(Uri.parse("http://${Config.baseUrl}/territories/byterritorieclimats?user_territorie_id=$id"));
    if (response.statusCode == 200) {
      final data = await json.decode(utf8.decode(response.bodyBytes));
      for (dynamic item in data) {
        groundList.add(Climat.fromJson(item));
      }
    }
    return groundList;
  }

  Future<List<Foundation>> getFoundationByPoint(int id) async {
    List<Foundation> groundList = [];
    final response = await http.get(Uri.parse("http://${Config.baseUrl}/territories/byterritoriefoundations?user_territorie_id=$id"));
    if (response.statusCode == 200) {
      final data = await json.decode(utf8.decode(response.bodyBytes));
      for (dynamic item in data) {
        groundList.add(Foundation.fromJson(item));
      }
    }
    return groundList;
  }

  static Future<void> deletePoint(int id) async {
    final response = await http.post(Uri.parse("http://${Config.baseUrl}/territories/delete?territorie_id=$id"));
  }
}
