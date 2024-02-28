class Water {
  final int id;
  final String name;
  final String description;

  Water({
    required this.id,
    required this.name,
    required this.description,
  });

  factory Water.fromJson(Map<String, dynamic> json) {
    return Water(
      id: json['water_id'] as int,
      name: json['water_name'] as String,
      description: json['water_description'] as String,
    );
  }

  @override
  String toString() {
    return name;
  }
}
