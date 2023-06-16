import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:soil/config.dart';
import '../models/Animal.dart';

class AnimalRepository {
  Future<List<Animal>> getAnimals() async {
    List<Animal> animalList = [];
    final response = await http.get(Uri.parse("http://${Config.baseUrl}/animals/all"));
    if (response.statusCode == 200) {
      final data = await json.decode(utf8.decode(response.bodyBytes));
      for (dynamic item in data) {
        animalList.add(Animal.fromJson(item));
      }
    }
    return animalList;
  }
  Future<Animal> getCurrentAnimal(int id) async {
    final response = await http.get(Uri.parse("http://${Config.baseUrl}/animals/one?animal_id=$id"));
    final data = await json.decode(utf8.decode(response.bodyBytes));
    Animal animal = Animal.fromJson(data[0]);
    return animal;
  }
  Future<void> insertAnimal(String name, String description) async {
    final response = await http.post(Uri.parse("http://${Config.baseUrl}/animals/insert?animal_name=$name&animal_description=$description"));
  }

  static Future<void> deleteAnimal(int id) async {
    final response = await http.post(Uri.parse("http://${Config.baseUrl}/animals/delete?animal_id=$id"));
  }
  static Future<int> updateDescription(int id, String value) async{
    int statusCode = 400;
    final response = await http.post(Uri.parse("http://${Config.baseUrl}/animals/update/description?animal_id=$id&animal_description=$value"));
    statusCode = response.statusCode;
    return statusCode;
  }
  static Future<int> updateKingdom(int id, String value) async{
    int statusCode = 400;
    final response = await http.post(Uri.parse("http://${Config.baseUrl}/animals/update/kingdom?animal_id=$id&animal_kingdom=$value"));
    statusCode = response.statusCode;
    return statusCode;
  }
  static Future<int> updatePhilum(int id, String value) async{
    int statusCode = 400;
    final response = await http.post(Uri.parse("http://${Config.baseUrl}/animals/update/philum?animal_id=$id&animal_philum=$value"));
    statusCode = response.statusCode;
    return statusCode;
  }
  static Future<int> updateClass(int id, String value) async{
    int statusCode = 400;
    final response = await http.post(Uri.parse("http://${Config.baseUrl}/animals/update/class?animal_id=$id&animal_class=$value"));
    statusCode = response.statusCode;
    return statusCode;
  }
  static Future<int> updateOrder(int id, String value) async{
    int statusCode = 400;
    final response = await http.post(Uri.parse("http://${Config.baseUrl}/animals/update/order?animal_id=$id&animal_order=$value"));
    statusCode = response.statusCode;
    return statusCode;
  }
  static Future<int> updateFamily(int id, String value) async{
    int statusCode = 400;
    final response = await http.post(Uri.parse("http://${Config.baseUrl}/animals/update/family?animal_id=$id&animal_family=$value"));
    statusCode = response.statusCode;
    return statusCode;
  }
  static Future<int> updateGenus(int id, String value) async{
    int statusCode = 400;
    final response = await http.post(Uri.parse("http://${Config.baseUrl}/animals/update/genus?animal_id=$id&animal_genus=$value"));
    statusCode = response.statusCode;
    return statusCode;
  }
  static Future<int> updateSpecies(int id, String value) async{
    int statusCode = 400;
    final response = await http.post(Uri.parse("http://${Config.baseUrl}/animals/update/species?animal_id=$id&animal_species=$value"));
    statusCode = response.statusCode;
    return statusCode;
  }
}