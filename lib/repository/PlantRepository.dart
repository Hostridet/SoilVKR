import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:soil/models/PlantAnimal.dart';
import 'package:soil/repository/AnimalRepository.dart';

import '../config.dart';
import '../models/Animal.dart';
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
  static Future<void> deleteConAnimal(int id) async {
    final response = await http.post(Uri.parse("http://${Config.baseUrl}/connectionplantsanimals/delete?connection_plants_animals_id=$id"));

  }
  static Future<int> insertConAnimal(int plantId, int animalId) async {
    int  statusCode = 404;
    final response = await http.post(Uri.parse("http://${Config.baseUrl}/connectionplantsanimals/insert?plant_id=$plantId&animal_id=$animalId"));
    statusCode = response.statusCode;
    return statusCode;
  }
  Future<List<PlantAnimal>> getAnimalCon() async {
    List<PlantAnimal> plantAnimalList = [];
    final response = await http.get(Uri.parse("http://${Config.baseUrl}/connectionplantsanimals/all"));
    if (response.statusCode == 200) {
      final data = await json.decode(utf8.decode(response.bodyBytes));
      for (dynamic item in data) {
        Plant plant = await getCurrentPlant(item['plant_id']);
        AnimalRepository animalRepository = AnimalRepository();
        Animal animal = await animalRepository.getCurrentAnimal(item['animal_id']);
        plantAnimalList.add(PlantAnimal(id: item['connection_plants_animals_id'], plant: plant, animal: animal));
      }
    }
    return plantAnimalList;
  }
}