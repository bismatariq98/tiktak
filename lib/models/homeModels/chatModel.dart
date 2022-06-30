// To parse this JSON data, do
//
//     final chatModel = chatModelFromJson(jsonString);

import 'dart:convert';

ChatModel chatModelFromJson(String str) => ChatModel.fromJson(json.decode(str));

String chatModelToJson(ChatModel data) => json.encode(data.toJson());

class ChatModel {
  ChatModel({
    this.success,
    this.message,
    this.chatroomId,
    this.data,
  });

  String success;
  String message;
  String chatroomId;
  List<Datum> data;

  factory ChatModel.fromJson(Map<String, dynamic> json) => ChatModel(
        success: json["success"],
        message: json["message"],
        chatroomId: json["chatroomId"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "chatroomId": chatroomId,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  Datum({
    this.id,
    this.sender,
    this.reciever,
    this.message,
    this.createdAt,
    this.status,
    this.chatRoomId,
  });

  String id;
  String sender;
  String reciever;
  String message;
  DateTime createdAt;
  String status;
  String chatRoomId;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        sender: json["sender"],
        reciever: json["reciever"],
        message: json["message"],
        createdAt: DateTime.parse(json["created_at"]),
        status: json["status"],
        chatRoomId: json["chat_room_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "sender": sender,
        "reciever": reciever,
        "message": message,
        "created_at": createdAt.toIso8601String(),
        "status": status,
        "chat_room_id": chatRoomId,
      };
}
