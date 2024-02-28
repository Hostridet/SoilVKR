class Relief {
  final int id;
  final String name;
  final String description;
  final String? image;

  const Relief({
    required this.id,
    required this.name,
    required this.description,
    required this.image,
  });

  factory Relief.fromJson(Map<String, dynamic> json) {
    return Relief(
      id: json['relief_id'] as int,
      name: json['relief_name'] as String,
      description: json['relief_description'] as String,
      image: json['relief_picture'] as String?,
    );
  }
  @override
  String toString() {
    return name;
  }
}
