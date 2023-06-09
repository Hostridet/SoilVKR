import 'dart:convert';
import 'package:http/http.dart' as http;
import '../config.dart';
import '../models/Soil.dart';

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
  static Future<void> deleteSoil(int id) async {
    final response = await http.post(Uri.parse("http://${Config.baseUrl}/soils/delete?soil_id=$id"));
  }
}