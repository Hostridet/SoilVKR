class Foundation {
  final int id;
  final String name;
  final String description;
  final String? image;

  const Foundation({
    required this.id,
    required this.name,
    required this.description,
    required this.image,
  });

  factory Foundation.fromJson(Map<String, dynamic> json) {
    return Foundation(
      id: json['foundation_id'] as int,
      name: json['foundation_name'] as String,
      description: json['foundation_description'] as String,
      image: json['foundation_picture'] as String?,
    );
  }
  @override
  String toString() {
    return name;
  }
}
