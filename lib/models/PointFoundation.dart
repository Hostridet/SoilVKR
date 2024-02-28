import 'package:soil/models/Foundation.dart';
import 'package:soil/models/Water.dart';

import 'Point.dart';

class PointFoundation {
  final int id;
  final Foundation foundation;
  final Point point;

  const PointFoundation({required this.id, required this.foundation, required this.point});
}
