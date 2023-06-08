import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:soil/models/Point.dart';

import '../config.dart';

class MapRepository {
  Future<List<dynamic>> getMapInfo(double long, double lat) async {
    int statusCode = 404;
    final response = await http.get(Uri.parse("http://${Config.baseUrl}/territories/bycoord?territorie_coord_x=$long&territorie_coord_y=$lat"));
    final data = await json.decode(utf8.decode(response.bodyBytes));
    statusCode = response.statusCode;
    return [Point.fromJson(data[0]) ,statusCode];
  }
  Future<void> updateMapInfo(int id, String address, double x, double y) async {
    final responseX = await http.post(Uri.parse("http://${Config.baseUrl}/territories/update/coord_x?territorie_id=$id&territorie_coord_x=$x"));
    final responseY = await http.post(Uri.parse("http://${Config.baseUrl}/territories/update/coord_y?territorie_id=$id&territorie_coord_y=$y"));
    final responseAddress = await http.post(Uri.parse("http://${Config.baseUrl}/territories/update/address?territorie_id=$id&territorie_address=$address"));
  }
  Future<void> addPoint(double x, double y, String address) async {
    final response = await http.post(Uri.parse("http://${Config.baseUrl}/territories/insert?territorie_coord_x=$x&territorie_coord_y=$y&territorie_address=$address"));
  }
}