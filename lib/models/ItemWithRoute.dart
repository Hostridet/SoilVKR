import '../../models/Point.dart';
import 'PointWithRoute.dart';

class ItemWithRoute {
  final int id;
  final String route;
  PointWithRoute? point;

  ItemWithRoute({
    required this.id,
    required this.route,
    this.point
  });
}