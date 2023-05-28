import 'dart:convert';
import 'package:http/http.dart' as http;


class MapRepository {
  Future<int> getMapInfo(double long, double lat) async {
    int statusCode = 404;
    final response = await http.get(Uri.parse("http://10.0.2.2:8080/territories/bycoord?territorie_coord_x=$long&territorie_coord_y=$lat"));
    statusCode = response.statusCode;
    return statusCode;
  }
  Future<void> updateMapInfo(int id, String address, double x, double y) async {
    final responseX = await http.post(Uri.parse("http://10.0.2.2:8080/territories/update/coord_x?territorie_id=$id&territorie_coord_x=$x"));
    final responseY = await http.post(Uri.parse("http://10.0.2.2:8080/territories/update/coord_y?territorie_id=$id&territorie_coord_y=$x"));
    final responseAddress = await http.post(Uri.parse("http://10.0.2.2:8080/territories/update/address?territorie_id=$id&territorie_address=$address"));
  }
}