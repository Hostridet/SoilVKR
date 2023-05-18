import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LoginRepository {
  Future<int> getLogIn(String login, String password) async {
    int statusCode = 401;
    try {
      final response = await http.post(Uri.parse("http://10.0.2.2:8080/users/authorisation/"),
          headers: {
            'Content-Type': 'application/json',
          },
          body: jsonEncode({
            "user_login": login,
            "user_password": password,
          })
      );
      final data = await json.decode(utf8.decode(response.bodyBytes));
      statusCode = response.statusCode;
      if (response.statusCode == 200) {
        final prefs = await SharedPreferences.getInstance();
        prefs.setInt("user_id", await json.decode(utf8.decode(response.bodyBytes))[0]['user_id']);
      }
    }
    catch(e) {}
    return statusCode;
  }
}