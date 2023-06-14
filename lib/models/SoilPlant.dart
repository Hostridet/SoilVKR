
import 'Plant.dart';
import 'Soil.dart';

class SoilPlant {
  final int id;
  final Soil soil;
  final Plant plant;

  SoilPlant({
    required this.id,
    required this.soil,
    required this.plant,
  });
}