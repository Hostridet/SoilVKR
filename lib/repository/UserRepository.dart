import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../config.dart';
import '../models/User.dart';

class UserRepository {
  Future<User> getUser() async {
    final prefs = await SharedPreferences.getInstance();
    int id = prefs.getInt("user_id")!;
    final response = await http.get(Uri.parse("http://${Config.baseUrl}/users/one?user_id=$id"));
    if (response.statusCode == 200) {
      final data = await json.decode(utf8.decode(response.bodyBytes));
      return User.fromJson(data[0]);
    }
    return User(id: 0, login: "Unknow", name: "Unknow", surname: "Unknow", fatherName: "Unknow", age: 0, isAdmin: 0, isFemale: 0, email: "Unknow");
  }

  Future<void> updateUser(User user) async {
    final prefs = await SharedPreferences.getInstance();
    int id = prefs.getInt("user_id")!;
    final responseName = await http.post(Uri.parse("http://${Config.baseUrl}/users/update/name?user_id=$id&user_name=${user.name}"));
    final responseSurname = await http.post(Uri.parse("http://${Config.baseUrl}/users/update/surname?user_id=$id&user_surname=${user.surname}"));
    final responseFatherName = await http.post(Uri.parse("http://${Config.baseUrl}/users/update/fathername?user_id=$id&user_fathername=${user.fatherName}"));
    final responseAge = await http.post(Uri.parse("http://${Config.baseUrl}/users/update/age?user_id=$id&user_age=${user.age}"));
    final responseEmail = await http.post(Uri.parse("http://${Config.baseUrl}/users/update/email?user_id=$id&user_email=${user.email}"));
    final responseGender = await http.post(Uri.parse("http://${Config.baseUrl}/users/update/isFemale?user_id=$id&user_isFemale=${user.isFemale}"));
  }

  Future<List<User>> getAllUser() async {
    List<User> userList = [];
    final response = await http.get(Uri.parse("http://${Config.baseUrl}/users/all"));
    if (response.statusCode == 200) {
      final data = await json.decode(utf8.decode(response.bodyBytes));
      for (dynamic item in data) {
        userList.add(User.fromJson(item));
      }
    }
    return userList;
  }

  Future<User> getUserById(int id) async {
    final response = await http.get(Uri.parse("http://${Config.baseUrl}/users/one?user_id=$id"));
    final data = await json.decode(utf8.decode(response.bodyBytes));
    return User.fromJson(data[0]);
  }
}