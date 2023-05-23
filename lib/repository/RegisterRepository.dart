import 'package:http/http.dart' as http;
import 'dart:convert';

class RegisterRepository {
  Future<int> makeRegister(String email, String login, String password) async {
    int statusCode = 405;
    final response = await http.post(Uri.parse("http://10.0.2.2:8080/users/insert"),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          "user_login": login,
          "user_password": password,
          "user_email": password,
        })
    );
    print(response.statusCode);
    statusCode = response.statusCode;
    return statusCode;
  }
}