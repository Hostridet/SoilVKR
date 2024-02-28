import 'package:soil/models/Foundation.dart';
import 'package:soil/models/Relief.dart';
import 'package:soil/models/Water.dart';

import 'Point.dart';

class PointRelief {
  final int id;
  final Relief relief;
  final Point point;

  const PointRelief({required this.id, required this.relief, required this.point});
}
