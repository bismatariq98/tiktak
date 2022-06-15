import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tik_tak/models/homeModels/videosModel.dart';
import 'package:http/http.dart' as http;

class VideosProvider with ChangeNotifier {
  GetVideosModel getVideosModel = GetVideosModel();
  bool loading = false;
  getPostData(context) async {
    loading = true;
    getVideosModel = await getVideosData(context);
    loading = false;
    notifyListeners();
  }

  Future<GetVideosModel> getVideosData(context) async {
    GetVideosModel result = GetVideosModel();
    try {
      final response = await http.get(
        Uri.parse("https://flutterapp.5techsol.com/api/video_data.php"),
      );
      if (response.statusCode == 200) {
        final item = json.decode(response.body);
        result = GetVideosModel.fromJson(item);
      } else {
        throw Exception('something wrong');
      }
    } catch (e) {
      print(e);
    }
    return result;
  }
}
