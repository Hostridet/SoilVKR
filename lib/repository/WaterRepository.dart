import 'dart:convert';

import 'package:soil/config.dart';
import 'package:soil/models/Water.dart';
import 'package:http/http.dart' as http;

class WaterRepository {
  Future<List<Water>> getWater() async {
    List<Water> climatList = [];
    final response = await http.get(Uri.parse("http://${Config.baseUrl}/waters/all"));
    if (response.statusCode == 200) {
      final data = await json.decode(utf8.decode(response.bodyBytes));
      for (dynamic item in data) {
        climatList.add(Water.fromJson(item));
      }
    }
    return climatList;
  }

  Future<Water> getCurrentWater(int id) async {
    final response = await http.get(Uri.parse("http://${Config.baseUrl}/waters/one?water_id=$id"));
    final data = await json.decode(utf8.decode(response.bodyBytes));
    Water climat = Water.fromJson(data[0]);
    return climat;
  }

  Future<void> insertWater(String name, String description) async {
    final response = await http.post(Uri.parse("http://${Config.baseUrl}/waters/insert?water_name=$name&water_description=$description"));
  }

  static Future<void> deleteWater(int id) async {
    final response = await http.post(Uri.parse("http://${Config.baseUrl}/waters/delete?water_id=$id"));
  }

  static Future<int> updateDescription(int id, String value) async {
    int statusCode = 400;
    final response = await http.post(Uri.parse("http://${Config.baseUrl}/waters/update/description?water_id=$id&water_description=$value"));
    statusCode = response.statusCode;
    return statusCode;
  }
}
