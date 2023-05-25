import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/Ground.dart';

class GroundRepository {
  Future<List<Ground>> getGround() async {
    List<Ground> groundList = [];
    final response = await http.get(Uri.parse("http://10.0.2.2:8080/grounds/all"));
    if (response.statusCode == 200) {
      final data = await json.decode(utf8.decode(response.bodyBytes));
      for (dynamic item in data) {
        groundList.add(Ground.fromJson(item));
      }
    }
    return groundList;
  }
  Future<Ground> getCurrentGround(int id) async {
    final response = await http.get(Uri.parse("http://10.0.2.2:8080/grounds/one?ground_id=$id"));
    final data = await json.decode(utf8.decode(response.bodyBytes));
    Ground ground = Ground.fromJson(data[0]);
    return ground;
  }
}