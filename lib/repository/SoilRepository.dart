import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/Soil.dart';

class SoilRepository {
  Future<List<Soil>> getSoils() async {
    List<Soil> soilList = [];
    final response = await http.get(Uri.parse("http://10.0.2.2:8080/soils/all"));
    if (response.statusCode == 200) {
      final data = await json.decode(utf8.decode(response.bodyBytes));
      for (dynamic item in data) {
        soilList.add(Soil.fromJson(item));
      }
    }
    return soilList;
  }
}