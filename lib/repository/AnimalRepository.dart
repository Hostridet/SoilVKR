import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/Animal.dart';

class AnimalRepository {
  Future<List<Animal>> getAnimals() async {
    List<Animal> animalList = [];
    final response = await http.get(Uri.parse("http://10.0.2.2:8080/animals/all"));
    if (response.statusCode == 200) {
      final data = await json.decode(utf8.decode(response.bodyBytes));
      for (dynamic item in data) {
        animalList.add(Animal.fromJson(item));
      }
    }
    return animalList;
  }
}