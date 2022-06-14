// To parse this JSON data, do
//
//     final currentUserModel = currentUserModelFromJson(jsonString);

import 'dart:convert';

CurrentUserModel currentUserModelFromJson(String str) =>
    CurrentUserModel.fromJson(json.decode(str));

String currentUserModelToJson(CurrentUserModel data) =>
    json.encode(data.toJson());

class CurrentUserModel {
  CurrentUserModel({
    this.success,
    this.message,
    this.data,
  });

  String success;
  String message;
  List<Datum> data;

  factory CurrentUserModel.fromJson(Map<String, dynamic> json) =>
      CurrentUserModel(
        success: json["success"],
        message: json["message"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  Datum({
    this.username,
    this.email,
    this.phoneNo,
  });

  String username;
  String email;
  String phoneNo;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        username: json["username"],
        email: json["email"],
        phoneNo: json["phone-no"],
      );

  Map<String, dynamic> toJson() => {
        "username": username,
        "email": email,
        "phone-no": phoneNo,
      };
}
