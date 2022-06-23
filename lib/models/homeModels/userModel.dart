// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

userModel userModelFromJson(String str) => userModel.fromJson(json.decode(str));
String userModelToJson(userModel data) => json.encode(data.toJson());

class userModel {
  userModel({
    this.success,
    this.message,
    this.data,
  });

  String success;
  String message;
  Data data;

  factory userModel.fromJson(Map<String, dynamic> json) => userModel(
        success: json["success"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data.toJson(),
      };
}

class Data {
  Data({
    this.userId,
    this.token,
  });

  String userId;
  String token;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        userId: json["user_id"],
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "token": token,
      };
}
