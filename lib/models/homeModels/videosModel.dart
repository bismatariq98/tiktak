// To parse this JSON data, do
//
//     final getVideosModel = getVideosModelFromJson(jsonString);

import 'dart:convert';

GetVideosModel getVideosModelFromJson(String str) =>
    GetVideosModel.fromJson(json.decode(str));

String getVideosModelToJson(GetVideosModel data) => json.encode(data.toJson());

class GetVideosModel {
  GetVideosModel({
    this.success,
    this.message,
    this.data,
  });

  String success;
  String message;
  List<Datum> data;

  factory GetVideosModel.fromJson(Map<String, dynamic> json) => GetVideosModel(
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
    this.videoDescription,
    this.videoFile,
    this.user,
    this.createdAt,
    this.likerIds,
  }); //ye dkhem video model pehle s bnna he iska rspnse dkhata usme ids ati hen or isne b string use kii hui

  String id;
  String videoDescription;
  String videoFile;
  String user;
  DateTime createdAt;
  List<String> likerIds;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        videoDescription: json["video_description"],
        videoFile: json["video_file"],
        user: json["user"],
        createdAt: DateTime.parse(json["created_at"]),
        likerIds: json["liker_ids"] == null
            ? null
            : List<String>.from(json["liker_ids"].map((x) => x)),
      );
//error kb ata ?ye kse chl gya??
  Map<String, dynamic> toJson() => {
        "id": id,
        "video_description": videoDescription,
        "video_file": videoFile,
        "user": user,
        "created_at": createdAt.toIso8601String(),
        "liker_ids": likerIds == null
            ? null
            : List<dynamic>.from(likerIds.map((x) => x)),
      };
}
