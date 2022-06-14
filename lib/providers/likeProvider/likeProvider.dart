import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../models/homeModels/getAllLikesModels.dart';

class LikeProvider with ChangeNotifier {
  GetLikesModal getallLikes = GetLikesModal();

  Future<bool> dolike(context, postId, CurrentUserID) async {
    bool check = true;
    final Map<String, String> body = {
      'post_id': postId,
      'user_id': CurrentUserID,
    };
    try {
      final response = await http.post(
          Uri.parse("https://flutterapp.5techsol.com/api/create_like.php"),
          body: body,
          headers: {
            "Content-Type": "application/x-www-form-urlencoded",
          });
    } catch (e) {
      print(e);
    }
  }

  Future<bool> deleteLike(context, postId, CurrentUserID) async {
    final Map<String, String> body = {
      'post_id': postId,
      'user_id': CurrentUserID,
    };
    try {
      final response = await http.post(
          Uri.parse("https://flutterapp.5techsol.com/api/delete_like.php"),
          body: body,
          headers: {
            "Content-Type": "application/x-www-form-urlencoded",
          });
      int b = 0;
    } catch (e) {
      print(e);
    }
  }

  notifyListeners();
}
