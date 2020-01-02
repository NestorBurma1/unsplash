import 'dart:convert';
import 'package:unsplash/models/image_model.dart';
import 'package:http/http.dart' as http;

class DataProvider {
  final String token =
      'https://api.unsplash.com/photos/?client_id=cf49c08b444ff4cb9e4d126b7e9f7513ba1ee58de7906e4360afc1a33d1bf4c0';

  Future<List<PhotoModel>> getPhotoModel() async {
    final response = await http.get(token);
    final dynamic jsonData = json.decode(response.body);
    final List<PhotoModel> list = [];
    for (dynamic i in jsonData) {
      final PhotoModel photoModel = PhotoModel(i['user']['name'],
          i['alt_description'], i['urls']['full'], i['urls']['thumb']);
      list.add(photoModel);
    }
    return list;
  }
}
