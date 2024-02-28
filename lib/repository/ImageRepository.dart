import 'dart:io';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
        }));
  }

  static Future<void> uploadPlantImage(int id) async {
    final ImagePicker picker = ImagePicker();
    var image = await picker.getImage(source: ImageSource.gallery);
    if (image == null) {
      return;
    }
    File _imageFile = File(image.path);
    Uint8List imageBytes = await _imageFile.readAsBytes();
    String _base64String = base64.encode(imageBytes);
    final responseName = await http.post(Uri.parse("http://${Config.baseUrl}/plants/update/picture"),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          "plant_id": id,
          "plant_picture": _base64String,
        }));
  }

  static Future<void> uploadGroundImage(int id) async {
    final ImagePicker picker = ImagePicker();
    var image = await picker.getImage(source: ImageSource.gallery);
    if (image == null) {
      return;
    }
    File _imageFile = File(image.path);
    Uint8List imageBytes = await _imageFile.readAsBytes();
    String _base64String = base64.encode(imageBytes);
    final responseName = await http.post(Uri.parse("http://${Config.baseUrl}/grounds/update/picture"),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          "ground_id": id,
          "ground_picture": _base64String,
        }));
  }

  static Future<void> uploadSoilImage(int id) async {
    final ImagePicker picker = ImagePicker();
    var image = await picker.getImage(source: ImageSource.gallery);
    if (image == null) {
      return;
    }
    File _imageFile = File(image.path);
    Uint8List imageBytes = await _imageFile.readAsBytes();
    String _base64String = base64.encode(imageBytes);
    final responseName = await http.post(Uri.parse("http://${Config.baseUrl}/soils/update/picture"),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          "soil_id": id,
          "soil_picture": _base64String,
        }));
  }

  static Future<void> uploadAnimalImage(int id) async {
    final ImagePicker picker = ImagePicker();
    var image = await picker.getImage(source: ImageSource.gallery);
    if (image == null) {
      return;
    }
    File _imageFile = File(image.path);
    Uint8List imageBytes = await _imageFile.readAsBytes();
    String _base64String = base64.encode(imageBytes);
    final responseName = await http.post(Uri.parse("http://${Config.baseUrl}/animals/update/picture"),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          "animal_id": id,
          "animal_picture": _base64String,
        }));
  }

  static Future<void> uploadFoundationImage(int id) async {
    final ImagePicker picker = ImagePicker();
    var image = await picker.getImage(source: ImageSource.gallery);
    if (image == null) {
      return;
    }
    File _imageFile = File(image.path);
    Uint8List imageBytes = await _imageFile.readAsBytes();
    String _base64String = base64.encode(imageBytes);
    final responseName = await http.post(Uri.parse("http://${Config.baseUrl}/foundations/update/picture"),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          "foundation_id": id,
          "foundation_picture": _base64String,
        }));
  }

  static Future<void> uploadReliefImage(int id) async {
    final ImagePicker picker = ImagePicker();
    var image = await picker.getImage(source: ImageSource.gallery);
    if (image == null) {
      return;
    }
    File _imageFile = File(image.path);
    Uint8List imageBytes = await _imageFile.readAsBytes();
    String _base64String = base64.encode(imageBytes);
    final responseName = await http.post(Uri.parse("http://${Config.baseUrl}/reliefs/update/picture"),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          "relief_id": id,
          "relief_picture": _base64String,
        }));
  }

  // static Future<String> getUserImage(int id) async {
  //   final prefs = await SharedPreferences.getInstance();
  //   if (prefs.getString("user/$id") == null) {
  //     final response = await http.get(Uri.parse("http://${Config.baseUrl}/users/get/picture?user_id=$id"));
  //     final data = await json.decode(utf8.decode(response.bodyBytes));
  //     prefs.setString("user/$id", data[0]['user_picture']);
  //     return data[0]['user_picture'];
  //   }
  //   return prefs.getString("user/$id")!;
  //
  // }
  static Future<String> getUserImage(int id) async {
    final prefs = await SharedPreferences.getInstance();
    final response = await http.get(Uri.parse("http://${Config.baseUrl}/users/get/picture?user_id=$id"));
    final data = await json.decode(utf8.decode(response.bodyBytes));
    prefs.setString("user/$id", data[0]['user_picture']);
    return data[0]['user_picture'];
  }

  static Future<String> getAnimalImage(int id) async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.getString("animal/$id") == null) {
      final response = await http.get(Uri.parse("http://${Config.baseUrl}/animals/get/picture?animal_id=$id"));
      final data = await json.decode(utf8.decode(response.bodyBytes));
      prefs.setString("animal/$id", data[0]['animal_picture']);
      return data[0]['animal_picture'];
    }
    return prefs.getString("animal/$id")!;
  }

  static Future<String> getPlantImage(int id) async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.getString("plant/$id") == null) {
      final response = await http.get(Uri.parse("http://${Config.baseUrl}/plants/get/picture?plant_id=$id"));
      final data = await json.decode(utf8.decode(response.bodyBytes));
      prefs.setString("plant/$id", data[0]['plant_picture']);
      return data[0]['plant_picture'];
    }
    return prefs.getString("plant/$id")!;
  }

  static Future<String> getGroundImage(int id) async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.getString("ground/$id") == null) {
      final response = await http.get(Uri.parse("http://${Config.baseUrl}/grounds/get/picture?ground_id=$id"));
      final data = await json.decode(utf8.decode(response.bodyBytes));
      prefs.setString("ground/$id", data[0]['ground_picture']);
      return data[0]['ground_picture'];
    }
    return prefs.getString("ground/$id")!;
  }

  static Future<String> getSoilImage(int id) async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.getString("soil/$id") == null) {
      final response = await http.get(Uri.parse("http://${Config.baseUrl}/soils/get/picture?soil_id=$id"));
      final data = await json.decode(utf8.decode(response.bodyBytes));
      prefs.setString("soil/$id", data[0]['soil_picture']);
      return data[0]['soil_picture'];
    }
    return prefs.getString("soil/$id")!;
  }

  static Future<String> getFoundationImage(int id) async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.getString("foundation/$id") == null) {
      final response = await http.get(Uri.parse("http://${Config.baseUrl}/foundations/get/picture?foundation_id=$id"));
      final data = await json.decode(utf8.decode(response.bodyBytes));
      prefs.setString("foundation/$id", data[0]['foundation_picture']);
      return data[0]['foundation_picture'];
    }
    return prefs.getString("foundation/$id")!;
  }

  static Future<String> getReliefImage(int id) async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.getString("relief/$id") == null) {
      final response = await http.get(Uri.parse("http://${Config.baseUrl}/reliefs/get/picture?relief_id=$id"));
      final data = await json.decode(utf8.decode(response.bodyBytes));
      prefs.setString("relief/$id", data[0]['relief_picture']);
      return data[0]['relief_picture'];
    }
    return prefs.getString("relief/$id")!;
  }
}
