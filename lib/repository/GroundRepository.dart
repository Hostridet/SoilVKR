import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/Ground.dart';
import 'package:soil/config.dart';

class GroundRepository {
  Future<List<Ground>> getGround() async {
    List<Ground> groundList = [];
    final response = await http.get(Uri.parse("http://${Config.baseUrl}/grounds/all"));
    if (response.statusCode == 200) {
      final data = await json.decode(utf8.decode(response.bodyBytes));
      for (dynamic item in data) {
        groundList.add(Ground.fromJson(item));
      }
    }
    return groundList;
  }
  Future<Ground> getCurrentGround(int id) async {
    final response = await http.get(Uri.parse("http://${Config.baseUrl}/grounds/one?ground_id=$id"));
    final data = await json.decode(utf8.decode(response.bodyBytes));
    Ground ground = Ground.fromJson(data[0]);
    return ground;
  }
  Future<void> insertGround(String name, String description) async {
    final response = await http.post(Uri.parse("http://${Config.baseUrl}/grounds/insert?ground_name=$name&ground_description=$description"));
  }
  static Future<void> deleteGround(int id) async {
    final response = await http.post(Uri.parse("http://${Config.baseUrl}/grounds/delete?ground_id=$id"));
  }
  static Future<int> updateName(int id, String value) async{
    int statusCode = 400;
    final response = await http.post(Uri.parse("http://${Config.baseUrl}/grounds/update/name?ground_id=$id&ground_name=$value"));
    statusCode = response.statusCode;
    return statusCode;
  }
  static Future<int> updateDescription(int id, String value) async{
    int statusCode = 400;
    final response = await http.post(Uri.parse("http://${Config.baseUrl}/grounds/update/description?ground_id=$id&ground_description=$value"));
    statusCode = response.statusCode;
    return statusCode;
  }
  static Future<int> updateDensity(int id, String value) async{
    int statusCode = 400;
    final response = await http.post(Uri.parse("http://${Config.baseUrl}/grounds/update/density?ground_id=$id&ground_density=${int.parse(value)}"));
    statusCode = response.statusCode;
    return statusCode;
  }
  static Future<int> updateHumidity(int id, String value) async{
    int statusCode = 400;
    final response = await http.post(Uri.parse("http://${Config.baseUrl}/grounds/update/humidity?ground_id=$id&ground_humidity=${int.parse(value)}"));
    statusCode = response.statusCode;
    return statusCode;
  }
  static Future<int> updateMoos(int id, String value) async{
    int statusCode = 400;
    final response = await http.post(Uri.parse("http://${Config.baseUrl}/grounds/update/hardness_Moos?ground_id=$id&ground_hardness_Moos=${int.parse(value)}"));
    statusCode = response.statusCode;
    return statusCode;
  }
}