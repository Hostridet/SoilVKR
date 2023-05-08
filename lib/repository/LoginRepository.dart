import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LoginRepository {
  Future<int> getLogIn(String login, String password) async {
    final response = await http.post(Uri.parse("http://10.0.2.2:5000/api/users/authorisation"),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          "login": login,
          "password": password,
        })
    );
    final data = await json.decode(utf8.decode(response.bodyBytes));
    if (response.statusCode == 200) {
      final prefs = await SharedPreferences.getInstance();
      prefs.setInt("user_id", await json.decode(utf8.decode(response.bodyBytes))[0]['user_id']);
    }
    return response.statusCode;
  }
}