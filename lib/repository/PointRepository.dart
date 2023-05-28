import '../models/Point.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class PointRepository {
  Future<List<Point>> getAllPoints() async {
    List<Point> pointList = [];
    final response = await http.get(Uri.parse("http://10.0.2.2:8080/territories/all"));
    if (response.statusCode == 200) {
      final data = await json.decode(utf8.decode(response.bodyBytes));
      for (dynamic item in data) {
        pointList.add(Point.fromJson(item));
      }
    }
    return pointList;
  }
}