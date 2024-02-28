import 'package:soil/models/Water.dart';

import 'Point.dart';

class PointWater {
  final int id;
  final Water water;
  final Point point;

  const PointWater({required this.id, required this.water, required this.point});
}
