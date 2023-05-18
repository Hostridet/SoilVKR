
class Plant {
  final int id;
  final String name;
  final String description;
  int? isFodder;
  int? isExacting;
  int? isOneYears;
  int? isTwoYears;
  int? isManyYears;
  String? climat;
  String? reqMinerals;
  int? minTemp;
  int? maxTemp;
  String? kingdom;
  String? philum;
  String? classes;
  String? order;
  String? family;
  String? genus;
  String? species;
  String? image;



Plant({
    required this.id,
    required this.name,
    required this.description,
    this.isFodder,
    this.isExacting,
    this.isOneYears,
    this.isTwoYears,
    this.isManyYears,
    this.climat,
    this.reqMinerals,
    this.minTemp,
    this.maxTemp,
    this.kingdom,
    this.philum,
    this.classes,
    this.order,
    this.family,
    this.genus,
    this.species,
    this.image
  });
  factory Plant.fromJson(Map<String, dynamic> json){
    return Plant(
      id: json['plant_id'] as int,
      name: json['plant_name'] as String,
      description: json['plant_description'] as String,
      isFodder: json['plant_isFodder'] as int?,
      isExacting: json['plant_isExactingToTheLight'] as int?,
      isOneYears: json['plant_isOneYears'] as int?,
      isTwoYears: json['plant_isTwoYears'] as int?,
      isManyYears: json['plant_isManyYears'] as int?,
      climat: json['plant_climat'] as String?,
      reqMinerals: json['plant_required_minerals_and_trace_elements'] as String?,
      minTemp: json['plant_temperature_min'] as int?,
      maxTemp: json['plant_temperature_max'] as int?,
      kingdom: json['plant_kingdom'] as String?,
      philum: json['plant_philum'] as String?,
      classes: json['plant_classes'] as String?,
      order: json['plant_order'] as String?,
      family: json['plant_family'] as String?,
      genus: json['plant_genus'] as String?,
      species: json['plant_species'] as String?,
      image: json['plant_picture'] as String?,
    );
  }
}