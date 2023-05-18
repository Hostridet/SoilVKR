import 'dart:convert';
import 'package:http/http.dart' as http;


class MapRepository {
  Future<int> getMapInfo(double long, double lat) async {
    int statusCode = 404;
    final response = await http.get(Uri.parse("http://10.0.2.2:8080/territories/bycoord?territorie_coord_x=$long&territorie_coord_y=$lat"));
    statusCode = response.statusCode;
    return statusCode;
  }
}