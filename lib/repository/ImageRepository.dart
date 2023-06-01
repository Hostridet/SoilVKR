import 'dart:io';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:image_picker/image_picker.dart';

import '../config.dart';

class ImageRepository {
  static Future<void> uploadImage() async {
    final ImagePicker picker = ImagePicker();
    var image = await picker.getImage(source: ImageSource.gallery);
    if (image == null) {
      return;
    }
    File _imageFile = File(image.path);
    Uint8List imageBytes = await _imageFile.readAsBytes();
    String _base64String = base64.encode(imageBytes);
    final prefs = await SharedPreferences.getInstance();
    int id = prefs.getInt("user_id")!;
    final responseName = await http.post(Uri.parse("http://${Config.baseUrl}/users/update/picture"),
        headers: {
        'Content-Type': 'application/json',
        },
        body: jsonEncode({
          "user_id": id,
          "user_picture": _base64String,
        })
    );
  }
  static Future<String> getUserImage(int id) async {
    final response = await http.get(Uri.parse("http://${Config.baseUrl}/users/get/picture?user_id=$id"));
    final data = await json.decode(utf8.decode(response.bodyBytes));
    return data[0]['user_picture'];
  }
}