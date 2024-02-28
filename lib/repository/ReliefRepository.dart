import 'dart:convert';

import 'package:soil/config.dart';
import 'package:soil/models/Relief.dart';
import 'package:http/http.dart' as http;

class ReliefRepository {
  Future<List<Relief>> getRelief() async {
    List<Relief> climatList = [];
    final response = await http.get(Uri.parse("http://${Config.baseUrl}/reliefs/all"));
    if (response.statusCode == 200) {
      final data = await json.decode(utf8.decode(response.bodyBytes));
      for (dynamic item in data) {
        climatList.add(Relief.fromJson(item));
      }
    }
    return climatList;
  }

  Future<Relief> getCurrentRelief(int id) async {
    final response = await http.get(Uri.parse("http://${Config.baseUrl}/reliefs/one?relief_id=$id"));
    final data = await json.decode(utf8.decode(response.bodyBytes));
    Relief climat = Relief.fromJson(data[0]);
    return climat;
  }

  Future<void> insertRelief(String name, String description) async {
    final response =
        await http.post(Uri.parse("http://${Config.baseUrl}/reliefs/insert?relief_name=$name&relief_description=$description"));
  }

  static Future<void> deleteRelief(int id) async {
    final response = await http.post(Uri.parse("http://${Config.baseUrl}/reliefs/delete?relief_id=$id"));
  }

  static Future<int> updateDescription(int id, String value) async {
    int statusCode = 400;
    final response =
        await http.post(Uri.parse("http://${Config.baseUrl}/reliefs/update/description?relief_id=$id&relief_description=$value"));
    statusCode = response.statusCode;
    return statusCode;
  }
}
