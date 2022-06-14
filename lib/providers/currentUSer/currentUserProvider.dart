import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tik_tak/models/homeModels/videosModel.dart';
import 'package:http/http.dart' as http;

import '../../models/homeModels/currentUserModel.dart';

class currentUserProvider with ChangeNotifier {
  CurrentUserModel currentUserModel = CurrentUserModel();
  getData(context) async {
    currentUserModel = await getCurrentUser(context);
    notifyListeners();
  }

  Future<CurrentUserModel> getCurrentUser(context) async {
    CurrentUserModel result = CurrentUserModel();
    try {
      final response = await http.post(
        Uri.parse("https://flutterapp.5techsol.com/api/single_user.php"),
      );
      if (response.statusCode == 200) {
        final item = json.decode(response.body);
        result = CurrentUserModel.fromJson(item);
      } else {
        throw Exception('something wrong');
      }
    } catch (e) {
      print(e);
    }
    return result;
  }
}
