import 'package:shared_preferences/shared_preferences.dart';

class AdminRepository {
  static Future<bool> isAdmin() async {
    final prefs = await SharedPreferences.getInstance();
    bool flag = false;
    if (prefs.getInt("isAdmin") == 1) {
      flag = true;
    }
    return flag;
  }
}