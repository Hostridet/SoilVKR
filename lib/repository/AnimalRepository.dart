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
}