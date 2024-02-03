import 'dart:convert';

import 'package:canverro_task/model/image_model.dart';
import 'package:http/http.dart' as http;

class ApiService {
  String endPoint = "https://picsum.photos/v2/list";
  Future<List<ImageModel>> fetchImages() async {
    final response = await http.get(Uri.parse(endPoint));
    if (response.statusCode == 200) {
      List<dynamic> image = jsonDecode(response.body);

      final ImageData = image.map((e) => ImageModel.fromJson(e)).toList();
      print(jsonDecode(response.body));
      return ImageData;
    } else {
      print("Something went wrong");
    }
    return [];
  }
}
