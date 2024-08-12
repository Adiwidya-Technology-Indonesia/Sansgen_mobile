// To parse this JSON data, do
//
//     final modelResponsePostComment = modelResponsePostCommentFromJson(jsonString);

import 'dart:convert';

ModelResponsePostComment modelResponsePostCommentFromJson(String str) => ModelResponsePostComment.fromJson(json.decode(str));

String modelResponsePostCommentToJson(ModelResponsePostComment data) => json.encode(data.toJson());

class ModelResponsePostComment {
  final Data data;

  ModelResponsePostComment({
    required this.data,
  });

  ModelResponsePostComment copyWith({
    Data? data,
  }) =>
      ModelResponsePostComment(
        data: data ?? this.data,
      );

  factory ModelResponsePostComment.fromJson(Map<String, dynamic> json) => ModelResponsePostComment(
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "data": data.toJson(),
  };
}

class Data {
  final int id;
  final String uuid;
  final String comment;
  final UserCommentPost user;

  Data({
    required this.id,
    required this.uuid,
    required this.comment,
    required this.user,
  });

  Data copyWith({
    int? id,
    String? uuid,
    String? comment,
    UserCommentPost? user,
  }) =>
      Data(
        id: id ?? this.id,
        uuid: uuid ?? this.uuid,
        comment: comment ?? this.comment,
        user: user ?? this.user,
      );

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    uuid: json["uuid"],
    comment: json["comment"],
    user: UserCommentPost.fromJson(json["user"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "uuid": uuid,
    "comment": comment,
    "user": user.toJson(),
  };
}

class UserCommentPost {
  final int id;
  final String uuid;
  final String name;

  UserCommentPost({
    required this.id,
    required this.uuid,
    required this.name,
  });

  UserCommentPost copyWith({
    int? id,
    String? uuid,
    String? name,
  }) =>
      UserCommentPost(
        id: id ?? this.id,
        uuid: uuid ?? this.uuid,
        name: name ?? this.name,
      );

  factory UserCommentPost.fromJson(Map<String, dynamic> json) => UserCommentPost(
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
