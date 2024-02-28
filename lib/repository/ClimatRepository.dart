import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:soil/config.dart';
import 'package:soil/models/Climat.dart';

class ClimatRepository {
  Future<List<Climat>> getCLimats() async {
    List<Climat> climatList = [];
    final response = await http.get(Uri.parse("http://${Config.baseUrl}/climats/all"));
    if (response.statusCode == 200) {
      final data = await json.decode(utf8.decode(response.bodyBytes));
      for (dynamic item in data) {
        climatList.add(Climat.fromJson(item));
      }
    }
    return climatList;
  }

  Future<Climat> getCurrentClimat(int id) async {
    final response = await http.get(Uri.parse("http://${Config.baseUrl}/climats/one?climat_id=$id"));
    final data = await json.decode(utf8.decode(response.bodyBytes));
    Climat climat = Climat.fromJson(data[0]);
    return climat;
  }

  Future<void> insertClimat(String name, String description) async {
    final response =
        await http.post(Uri.parse("http://${Config.baseUrl}/climats/insert?climat_name=$name&climat_description=$description"));
  }

  static Future<void> deleteClimat(int id) async {
    final response = await http.post(Uri.parse("http://${Config.baseUrl}/climats/delete?climat_id=$id"));
  }

  static Future<int> updateDescription(int id, String value) async {
    int statusCode = 400;
    final response =
        await http.post(Uri.parse("http://${Config.baseUrl}/climats/update/description?climat_id=$id&climat_description=$value"));
    statusCode = response.statusCode;
    return statusCode;
  }
}
