import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../models/homeModels/currentUserModel.dart';

class CurrentUserProvider with ChangeNotifier {
  CurrentLoggedUserModel currentUserModel = CurrentLoggedUserModel();
  getData(context, String userID) async {
    currentUserModel = await getCurrentUser(context, userID);
    notifyListeners();
  }

  Future<CurrentLoggedUserModel> getCurrentUser(context, String userID) async {
    CurrentLoggedUserModel result = CurrentLoggedUserModel();
    final Map<String, String> body = {'id': userID};

    final response = await http.post(
        Uri.parse("https://flutterapp.5techsol.com/api/account_info.php"),
        body: body,
        headers: {
          "Content-Type": "application/x-www-form-urlencoded",
        });
    if (response.statusCode == 200) {
      final item = json.decode(response.body);
      if (item != null) {
        print("I am not null");
      } else
        print("I am Null");
      result = CurrentLoggedUserModel.fromJson(item);
    } else {
      throw Exception('something wrong');
    }

    return result;
  }
}
