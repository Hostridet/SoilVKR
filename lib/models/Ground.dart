
class Ground {
  int id;
  String name;
  String description;
  int? density;
  int? humidity;
  int? moos;
  String? image;

  Ground({
    required this.id,
    required this.name,
    required this.description,
    this.density,
    this.humidity,
    this.moos,
    this.image,
  });
  factory Ground.fromJson(Map<String, dynamic> json){
    return Ground(
      id: json['ground_id'] as int,
      name: json['ground_name'] as String,
      description: json['ground_description'] as String,
      density: json['ground_density'] as int?,
      humidity: json['ground_humidity'] as int?,
      moos: json['ground_hardness_Moos'] as int?,
      image: json['ground_picture'] as String?,
    );
  }
  @override
  String toString() {
    return name;
  }
}