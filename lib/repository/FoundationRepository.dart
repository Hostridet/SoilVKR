import 'dart:convert';

import 'package:soil/config.dart';
import 'package:soil/models/Foundation.dart';
import 'package:http/http.dart' as http;

class FoundationRepository {
  Future<List<Foundation>> getFoundation() async {
    List<Foundation> climatList = [];
    final response = await http.get(Uri.parse("http://${Config.baseUrl}/foundations/all"));
    if (response.statusCode == 200) {
      final data = await json.decode(utf8.decode(response.bodyBytes));
      for (dynamic item in data) {
        climatList.add(Foundation.fromJson(item));
      }
    }
    return climatList;
  }

  Future<Foundation> getCurrentFoundation(int id) async {
    final response = await http.get(Uri.parse("http://${Config.baseUrl}/foundations/one?foundation_id=$id"));
    final data = await json.decode(utf8.decode(response.bodyBytes));
    Foundation climat = Foundation.fromJson(data[0]);
    return climat;
  }

  Future<void> insertFoundation(String name, String description) async {
    final response =
        await http.post(Uri.parse("http://${Config.baseUrl}/foundations/insert?foundation_name=$name&foundation_description=$description"));
  }

  static Future<void> deleteFoundation(int id) async {
    final response = await http.post(Uri.parse("http://${Config.baseUrl}/foundations/delete?foundation_id=$id"));
  }

  static Future<int> updateDescription(int id, String value) async {
    int statusCode = 400;
    final response = await http
        .post(Uri.parse("http://${Config.baseUrl}/foundations/update/description?foundation_id=$id&foundation_description=$value"));
    statusCode = response.statusCode;
    return statusCode;
  }
}
