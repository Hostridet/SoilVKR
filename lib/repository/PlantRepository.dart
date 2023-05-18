import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/Plant.dart';

class PlantRepository {
  Future<List<Plant>> getPlants() async {
    List<Plant> plantList = [];
    final response = await http.get(Uri.parse("http://10.0.2.2:8080/plants/all"));
    if (response.statusCode == 200) {
      final data = await json.decode(utf8.decode(response.bodyBytes));
      for (dynamic item in data) {
        plantList.add(Plant.fromJson(item));
      }
    }
    return plantList;
  }
}