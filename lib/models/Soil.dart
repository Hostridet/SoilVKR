
class Soil {
  final int id;
  final String name;
  final String description;
  String? acidity;
  String? minerals;
  String? profile;
  String? image;
  Soil({
    required this.id,
    required this.name,
    required this.description,
    this.profile,
    this.acidity,
    this.minerals,
    this.image
  });
  factory Soil.fromJson(Map<String, dynamic> json){
    return Soil(
      id: json['soil_id'] as int,
      name: json['soil_name'] as String,
      description: json['soil_description'] as String,
      profile: json['soil_profile'] as String?,
      acidity: json['soil_acidity'] as String?,
      minerals: json['soil_minerals'] as String?,
      image: json['soil_picture'] as String?,
    );
  }
  @override
  String toString() {
    return name;
  }
}