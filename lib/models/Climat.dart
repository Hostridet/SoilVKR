class Climat {
  final int id;
  final String name;
  final String description;

  Climat({
    required this.id,
    required this.name,
    required this.description,
  });

  factory Climat.fromJson(Map<String, dynamic> json) {
    return Climat(
      id: json['climat_id'] as int,
      name: json['climat_name'] as String,
      description: json['climat_description'] as String,
    );
  }

  @override
  String toString() {
    return name;
  }
}
