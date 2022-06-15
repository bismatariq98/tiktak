// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

userModel userModelFromJson(String str) =>
    userModel.fromJson(json.decode(str)); // ya use hta h jason ko
//body mai vovert krny k luyay yani aik variable mai stor krvany k luyay for further use puch rahiaen k btaa raheinnn?
//pch rhi hu ,,pta ni...ye to auto generated model he...api ka response aik website h uspe daaalo wo khudi model bna deta he..
// i know  bht sari web h dart to jason ki
// ab mai ny ap sy classess lia krni h :)
//acha use

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
