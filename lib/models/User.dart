class User {
  final int id;
  final String login;
  String? name;
  String? surname;
  String? fatherName;
  int? age;
  final int isAdmin;
  int? isFemale;
  final String email;
  String? image;

  User({
    required this.id,
    required this.login,
    this.name,
    this.surname,
    this.fatherName,
    this.age,
    required this.isAdmin,
    this.isFemale,
    required this.email,
    this.image
  });
  factory User.fromJson(Map<String, dynamic> json){
    return User(
      id: json['user_id'] as int,
      login: json['user_login'] as String,
      name: json['user_name'] as String?,
      surname: json['user_surname'] as String?,
      fatherName: json['user_fathername'] as String?,
      age: json['user_age'] as int?,
      isAdmin: json['user_isAdmin'] as int,
      isFemale: json['user_isFemale'] as int?,
      email: json['user_email'] as String,
      image: json['user_picture'] as String?,
    );
  }

}