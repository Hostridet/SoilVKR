import 'dart:convert';
import 'package:http/http.dart' as http;

import '../config.dart';
import '../models/Plant.dart';

class PlantRepository {
  Future<List<Plant>> getPlants() async {
    List<Plant> plantList = [];
    final response = await http.get(Uri.parse("http://${Config.baseUrl}/plants/all"));
    if (response.statusCode == 200) {
      final data = await json.decode(utf8.decode(response.bodyBytes));
      for (dynamic item in data) {
        plantList.add(Plant.fromJson(item));
      }
    }
    return plantList;
  }
  Future<Plant> getCurrentPlant(int id) async {
    final response = await http.get(Uri.parse("http://${Config.baseUrl}/plants/one?plant_id=${id}"));
    final data = await json.decode(utf8.decode(response.bodyBytes));
    Plant plant = Plant.fromJson(data[0]);
    return plant;
  }

  Future<void> insertPlant(String name, String description, bool isFodder) async {
    int value = 0;
    isFodder ? value = 1 : value = 0;
    final response = await http.post(Uri.parse("http://${Config.baseUrl}/plants/insert?plant_name=$name&plant_description=$description&plant_isFodder=$value"));
  }
  static Future<void> deletePlant(int id) async {
    final response = await http.post(Uri.parse("http://${Config.baseUrl}/plants/delete?plant_id=$id"));
  }
}