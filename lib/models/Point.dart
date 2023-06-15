
class Point {
  int id;
  double x;
  double y;
  String? address;

  Point({
    required this.id,
    required this.x,
    required this.y,
    this.address
  });

  factory Point.fromJson(Map<String, dynamic> json){
    return Point(
      id: json['territorie_id'] as int,
      x: json['territorie_coord_x'] as double,
      y: json['territorie_coord_y'] as double,
      address: json['territorie_address'] as String?,
    );
  }
  @override
  String toString() {
    return "$x $y";
  }
}