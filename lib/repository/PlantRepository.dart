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

  static Future<int> updateDescription(int id, String value) async{
    int statusCode = 400;
    final response = await http.post(Uri.parse("http://${Config.baseUrl}/plants/update/description?plant_id=$id&plant_description=$value"));
    statusCode = response.statusCode;
    return statusCode;
  }
  static Future<int> updateIsFodder(int id, int value) async{
    int statusCode = 400;
    final response = await http.post(Uri.parse("http://${Config.baseUrl}/plants/update/isFodder?plant_id=$id&plant_isFodder=$value"));
    statusCode = response.statusCode;
    return statusCode;
  }
  static Future<int> updateIsExacting(int id, int value) async{
    int statusCode = 400;
    final response = await http.post(Uri.parse("http://${Config.baseUrl}/plants/update/isExactingToTheLight?plant_id=$id&plant_isExactingToTheLight=$value"));
    statusCode = response.statusCode;
    return statusCode;
  }
  static Future<int> updateIsOneYear(int id, int value) async{
    int statusCode = 400;
    final response = await http.post(Uri.parse("http://${Config.baseUrl}/plants/update/isOneYear?plant_id=$id&plant_isOneYear=$value"));
    statusCode = response.statusCode;
    return statusCode;
  }
  static Future<int> updateIsTwoYear(int id, int value) async{
    int statusCode = 400;
    final response = await http.post(Uri.parse("http://${Config.baseUrl}/plants/update/isTwoYear?plant_id=$id&plant_isTwoYear=$value"));
    statusCode = response.statusCode;
    return statusCode;
  }
  static Future<int> updateIsManyYear(int id, int value) async{
    int statusCode = 400;
    final response = await http.post(Uri.parse("http://${Config.baseUrl}/plants/update/isManyYear?plant_id=$id&plant_isManyYear=$value"));
    statusCode = response.statusCode;
    return statusCode;
  }
  static Future<int> updateClimat(int id, String value) async{
    int statusCode = 400;
    final response = await http.post(Uri.parse("http://${Config.baseUrl}/plants/update/climat?plant_id=$id&plant_climat=$value"));
    statusCode = response.statusCode;
    print(statusCode);
    return statusCode;
  }
  static Future<int> updateTempMin(int id, String value) async{
    int statusCode = 400;
    final response = await http.post(Uri.parse("http://${Config.baseUrl}/plants/update/temperaturemin?plant_id=$id&plant_temperature_min=${int.parse(value)}"));
    statusCode = response.statusCode;
    return statusCode;
  }
  static Future<int> updateTempMax(int id, String value) async{
    int statusCode = 400;
    final response = await http.post(Uri.parse("http://${Config.baseUrl}/plants/update/temperaturemax?plant_id=$id&plant_temperature_max=${int.parse(value)}"));
    statusCode = response.statusCode;
    return statusCode;
  }
  static Future<int> updateKingdom(int id, String value) async{
    int statusCode = 400;
    final response = await http.post(Uri.parse("http://${Config.baseUrl}/plants/update/kingdom?plant_id=$id&plant_kingdom=$value"));
    statusCode = response.statusCode;
    return statusCode;
  }
  static Future<int> updatePhilum(int id, String value) async{
    int statusCode = 400;
    final response = await http.post(Uri.parse("http://${Config.baseUrl}/plants/update/philum?plant_id=$id&plant_philum=$value"));
    statusCode = response.statusCode;
    return statusCode;
  }
  static Future<int> updateClass(int id, String value) async{
    int statusCode = 400;
    final response = await http.post(Uri.parse("http://${Config.baseUrl}/plants/update/class?plant_id=$id&plant_class=$value"));
    statusCode = response.statusCode;
    return statusCode;
  }
  static Future<int> updateOrder(int id, String value) async{
    int statusCode = 400;
    final response = await http.post(Uri.parse("http://${Config.baseUrl}/plants/update/order?plant_id=$id&plant_order=$value"));
    statusCode = response.statusCode;
    return statusCode;
  }
  static Future<int> updateFamily(int id, String value) async{
    int statusCode = 400;
    final response = await http.post(Uri.parse("http://${Config.baseUrl}/plants/update/family?plant_id=$id&plant_family=$value"));
    statusCode = response.statusCode;
    return statusCode;
  }
  static Future<int> updateGenus(int id, String value) async{
    int statusCode = 400;
    final response = await http.post(Uri.parse("http://${Config.baseUrl}/plants/update/genus?plant_id=$id&plant_genus=$value"));
    statusCode = response.statusCode;
    return statusCode;
  }
  static Future<int> updateSpecies(int id, String value) async{
    int statusCode = 400;
    final response = await http.post(Uri.parse("http://${Config.baseUrl}/plants/update/species?plant_id=$id&plant_species=$value"));
    statusCode = response.statusCode;
    print(value);
    return statusCode;
  }
}