// To parse this JSON data, do
//
//     final modelResponseGetComment = modelResponseGetCommentFromJson(jsonString);

import 'dart:convert';

ModelResponseGetComment modelResponseGetCommentFromJson(String str) => ModelResponseGetComment.fromJson(json.decode(str));

String modelResponseGetCommentToJson(ModelResponseGetComment data) => json.encode(data.toJson());

class ModelResponseGetComment {
  final bool status;
  final String message;
  final List<UserCommentGet> data;

  ModelResponseGetComment({
    required this.status,
    required this.message,
    required this.data,
  });

  ModelResponseGetComment copyWith({
    bool? status,
    String? message,
    List<UserCommentGet>? data,
  }) =>
      ModelResponseGetComment(
        status: status ?? this.status,
        message: message ?? this.message,
        data: data ?? this.data,
      );

  factory ModelResponseGetComment.fromJson(Map<String, dynamic> json) => ModelResponseGetComment(
    status: json["status"],
    message: json["message"],
    data: List<UserCommentGet>.from(json["data"].map((x) => UserCommentGet.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class UserCommentGet {
  final int id;
  final String uuid;
  final String comment;
  final User user;

  UserCommentGet({
    required this.id,
    required this.uuid,
    required this.comment,
    required this.user,
  });

  UserCommentGet copyWith({
    int? id,
    String? uuid,
    String? comment,
    User? user,
  }) =>
      UserCommentGet(
        id: id ?? this.id,
        uuid: uuid ?? this.uuid,
        comment: comment ?? this.comment,
        user: user ?? this.user,
      );

  factory UserCommentGet.fromJson(Map<String, dynamic> json) => UserCommentGet(
    id: json["id"],
    uuid: json["uuid"],
    comment: json["comment"],
    user: User.fromJson(json["user"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "uuid": uuid,
    "comment": comment,
    "user": user.toJson(),
  };
}

class User {
  final int id;
  final String uuid;
  final String name;

  User({
    required this.id,
    required this.uuid,
    required this.name,
  });

  User copyWith({
    int? id,
    String? uuid,
    String? name,
  }) =>
      User(
        id: id ?? this.id,
        uuid: uuid ?? this.uuid,
        name: name ?? this.name,
      );

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    uuid: json["uuid"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "uuid": uuid,
    "name": name,
  };
}
