import 'package:soil/models/Climat.dart';

import 'Soil.dart';
import 'Point.dart';

class PointClimat {
  final int id;
  final Climat climat;
  final Point point;

  const PointClimat({required this.id, required this.climat, required this.point});
}
