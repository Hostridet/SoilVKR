import 'dart:io';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:image_picker/image_picker.dart';

import '../config.dart';

class ImageRepository {
  static Future<void> getImage() async {
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
          "image": _base64String,
        })
    );
  }
}