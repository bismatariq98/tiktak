// To parse this JSON data, do
//
//     final currentLoggedUserModel = currentLoggedUserModelFromJson(jsonString);

import 'dart:convert';

CurrentLoggedUserModel currentLoggedUserModelFromJson(String str) =>
    CurrentLoggedUserModel.fromJson(json.decode(str));

String currentLoggedUserModelToJson(CurrentLoggedUserModel data) =>
    json.encode(data.toJson());

class CurrentLoggedUserModel {
  CurrentLoggedUserModel({
    this.success,
    this.message,
    this.data,
  });

  String success;
  String message;
  List<Datum> data;

  factory CurrentLoggedUserModel.fromJson(Map<String, dynamic> json) =>
      CurrentLoggedUserModel(
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
    this.username,
    this.phoneNo,
    this.email,
    this.description,
    this.createdDate,
    this.booked,
    this.totalReviews,
    this.allReviews,
    this.totalLikes,
    this.totalPosts,
    this.allPosts,
  });

  String id;
  String username;
  String phoneNo;
  String email;
  String description;
  DateTime createdDate;
  String booked;
  int totalReviews;
  List<AllReview> allReviews;
  String totalLikes;
  int totalPosts;
  List<AllPost> allPosts;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        username: json["username"],
        phoneNo: json["phone-no"],
        email: json["email"],
        description: json["description"],
        createdDate: DateTime.parse(json["created_date"]),
        booked: json["booked"],
        totalReviews: json["Total_reviews"],
        allReviews: List<AllReview>.from(
            json["all_reviews"].map((x) => AllReview.fromJson(x))),
        totalLikes: json["total_likes"],
        totalPosts: json["total_posts"],
        allPosts: List<AllPost>.from(
            json["all_posts"].map((x) => AllPost.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
        "phone-no": phoneNo,
        "email": email,
        "description": description,
        "created_date": createdDate.toIso8601String(),
        "booked": booked,
        "Total_reviews": totalReviews,
        "all_reviews": List<dynamic>.from(allReviews.map((x) => x.toJson())),
        "total_likes": totalLikes,
        "total_posts": totalPosts,
        "all_posts": List<dynamic>.from(allPosts.map((x) => x.toJson())),
      };
}

class AllPost {
  AllPost({
    this.id,
    this.user,
    this.videoDescription,
    this.videoFile,
    this.createdAt,
  });

  String id;
  String user;
  String videoDescription;
  String videoFile;
  DateTime createdAt;

  factory AllPost.fromJson(Map<String, dynamic> json) => AllPost(
        id: json["id"],
        user: json["user"],
        videoDescription: json["video_description"],
        videoFile: json["video_file"],
        createdAt: DateTime.parse(json["created_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user": user,
        "video_description": videoDescription,
        "video_file": videoFile,
        "created_at": createdAt.toIso8601String(),
      };
}

class AllReview {
  AllReview({
    this.id,
    this.comment,
    this.rating,
    this.reviewerId,
    this.userId,
  });

  String id;
  Comment comment;
  String rating;
  String reviewerId;
  String userId;

  factory AllReview.fromJson(Map<String, dynamic> json) => AllReview(
        id: json["id"],
        comment: commentValues.map[json["comment"]],
        rating: json["rating"],
        reviewerId: json["reviewer_id"],
        userId: json["user_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "comment": commentValues.reverse[comment],
        "rating": rating,
        "reviewer_id": reviewerId,
        "user_id": userId,
      };
}

enum Comment { IQBAL, TESTING }

final commentValues =
    EnumValues({"IQBAL": Comment.IQBAL, "TESTING": Comment.TESTING});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
