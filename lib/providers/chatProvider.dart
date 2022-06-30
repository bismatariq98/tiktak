import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tik_tak/models/homeModels/chatModel.dart';
import 'package:http/http.dart' as http;

class ChatProvider with ChangeNotifier {
  ChatModel chatDetails = ChatModel();

  getChatData(context, String currentUserID, String otherUserID) async {
    chatDetails = await getChat(context, currentUserID, otherUserID);
    notifyListeners();
  }

  Future<ChatModel> getChat(
      context, String currentUserID, String otherUserID) async {
    ChatModel result = ChatModel();

    final Map<String, String> body = {
      'user_one_id': currentUserID,
      'user_two_id': otherUserID,
    };

    final response = await http.post(
        Uri.parse('https://flutterapp.5techsol.com/api/get_chat_by_room.php'),
        body: body,
        headers: {
          "Content-Type": "application/x-www-form-urlencoded",
        });
    if (response.statusCode == 200) {
      final item = json.decode(response.body);
      result = ChatModel.fromJson(item);
    } else {
      throw Exception('something wrong');
    }

    return result;
  }
}
