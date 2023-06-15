

class Animal {
  final int id;
  final String name;
  final String description;
  String? kingdom;
  String? classes;
  String? order;
  String? family;
  String? genus;
  String? species;
  String? picture;
  String? philum;

  Animal({
    required this.id,
    required this.name,
    required this.description,
    this.kingdom,
    this.classes,
    this.order,
    this.family,
    this.genus,
    this.species,
    this.picture,
    this.philum
  });

  factory Animal.fromJson(Map<String, dynamic> json){
    return Animal(
      id: json['animal_id'] as int,
      name: json['animal_name'] as String,
      description: json['animal_description'] as String,
      kingdom: json['animal_kingdom'] as String?,
      classes: json['animal_class'] as String?,
      order: json['animal_order'] as String?,
      family: json['animal_family'] as String?,
      genus: json['animal_genus'] as String?,
      species: json['animal_species'] as String?,
      picture: json['animal_picture'] as String?,
      philum: json['animal_philum'] as String?,
    );
  }
  @override
  String toString() {
    return name;
  }
}