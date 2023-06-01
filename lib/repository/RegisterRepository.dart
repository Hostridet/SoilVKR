import 'package:http/http.dart' as http;
import 'dart:convert';

import '../config.dart';

class RegisterRepository {
  Future<int> makeRegister(String email, String login, String password) async {
    int statusCode = 405;
    final response = await http.post(Uri.parse("http://${Config.baseUrl}/users/insert"),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          "user_login": login,
          "user_password": password,
          "user_email": email,
        })
    );
    print(await json.decode(utf8.decode(response.bodyBytes)));
    statusCode = response.statusCode;
    return statusCode;
  }
}