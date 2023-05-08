class User {
  final int id;
  final String login;
  final String name;
  final String surname;
  final String fatherName;
  final int age;
  final int isAdmin;
  final int isFemale;
  final String email;

  User({
    required this.id,
    required this.login,
    required this.name,
    required this.surname,
    required this.fatherName,
    required this.age,
    required this.isAdmin,
    required this.isFemale,
    required this.email
  });
  factory User.fromJson(Map<String, dynamic> json){
    return User(
      id: json['user_id'] as int,
      login: json['user_login'] as String,
      name: json['user_name'] as String,
      surname: json['user_surname'] as String,
      fatherName: json['user_fathername'] as String,
      age: json['user_age'] as int,
      isAdmin: json['user_isAdmin'] as int,
      isFemale: json['user_isFemale'] as int,
      email: json['user_email'] as String,
    );
  }

}