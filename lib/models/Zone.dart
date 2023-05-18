

class Zones {
  int soil_id;
  String soil_name;
  String soil_description;
  String? soil_picture;
  String ground_name;
  String ground_description;
  String? ground_picture;
  int plant_id;
  String plant_name;
  String plant_description;
  String? plant_climat;
  int? plant_temperature_min;
  int? plant_temperature_max;
  int? connection_soils_plants_isGood;
  String? plant_picture;
  int animal_id;
  String animal_name;
  String animal_description;
  String? animal_picture;

  Zones({
      required this.soil_id,
      required this.soil_name,
      required this.soil_description,
      this.soil_picture,
      required this.ground_name,
      required this.ground_description,
      this.ground_picture,
      required this.plant_id,
      required this.plant_name,
      required this.plant_description,
      this.plant_climat,
      this.plant_temperature_min,
      this.plant_temperature_max,
      this.connection_soils_plants_isGood,
      this.plant_picture,
      required this.animal_id,
      required this.animal_name,
      required this.animal_description,
      this.animal_picture
  });

  factory Zones.fromJson(Map<String, dynamic> json){
    return Zones(
        soil_id: json['soil_id'] as int,
        soil_name: json['soil_name'] as String,
        soil_description: json['soil_description'] as String,
        soil_picture: json['soil_picture'] as String?,
        ground_name: json['ground_name'] as String,
        ground_description: json['ground_description'] as String,
        ground_picture: json['ground_picture'] as String?,
        plant_id: json['plant_id'] as int,
        plant_name: json['plant_name'] as String,
        plant_description: json['plant_description'] as String,
        plant_climat: json['plant_climat'] as String?,
        plant_temperature_min: json['plant_temperature_min'] as int?,
        plant_temperature_max: json['plant_temperature_max'] as int?,
        connection_soils_plants_isGood: json['connection_soils_plants_isGood'] as int?,
        plant_picture: json['plant_picture'] as String?,
        animal_id: json['animal_id'] as int,
        animal_name: json['animal_name'] as String,
        animal_description: json['animal_description'] as String,
        animal_picture: json['animal_picture'] as String?,


    );
  }
}