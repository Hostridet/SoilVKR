import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:soil/models/Zone.dart';

class ZoneRepository {
  Future<Zones> getZoneInfo(double long, double lat) async {
    final response = await http.get(Uri.parse("http://10.0.2.2:8080/territories/bycoord?territorie_coord_x=$long&territorie_coord_y=$lat"));
    final data = await json.decode(utf8.decode(response.bodyBytes));
    return Zones.fromJson(data[0]);
  }
}