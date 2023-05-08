import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../models/User.dart';

class UserRepository {
  Future<User> getUser() async {
    final prefs = await SharedPreferences.getInstance();
    int id = prefs.getInt("user_id")!;
    final response = await http.get(Uri.parse("http://10.0.2.2:5000/api/users/getoneuser?user_id=$id"));
    if (response.statusCode == 200) {
      final data = await json.decode(utf8.decode(response.bodyBytes));
      return User.fromJson(data[0]);
    }
    return User(id: 0, login: "Unknow", name: "Unknow", surname: "Unknow", fatherName: "Unknow", age: 0, isAdmin: 0, isFemale: 0, email: "Unknow");
  }
}