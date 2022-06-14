// To parse this JSON data, do
//
//     final getLikesModal = getLikesModalFromJson(jsonString);

import 'dart:convert';

GetLikesModal getLikesModalFromJson(String str) =>
    GetLikesModal.fromJson(json.decode(str));

String getLikesModalToJson(GetLikesModal data) => json.encode(data.toJson());

class GetLikesModal {
  GetLikesModal({
    this.success,
    this.message,
    this.data,
  });

  String success;
  String message;
  List<Datum> data;

  factory GetLikesModal.fromJson(Map<String, dynamic> json) => GetLikesModal(
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
    this.id,
    this.postId,
    this.userId,
    this.createdAt,
  });

  String id;
  String postId;
  String userId;
  DateTime createdAt;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        postId: json["post_id"],
        userId: json["user_id"],
        createdAt: DateTime.parse(json["created_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "post_id": postId,
        "user_id": userId,
        "created_at": createdAt.toIso8601String(),
      };
}
