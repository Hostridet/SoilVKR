import 'package:http/http.dart' as http;
import 'dart:convert';

class RegisterRepository {
  Future<String> makeRegister(String email, String login, String password) async {
    String statusCode = "";
    try {
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
      final data = await json.decode(utf8.decode(response.bodyBytes));
      statusCode = data;
    }
    catch(e) {}
    return statusCode;
  }
}