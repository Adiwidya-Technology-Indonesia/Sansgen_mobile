// To parse this JSON data, do
//
//     final modelResponseGetChapter = modelResponseGetChapterFromJson(jsonString);

import 'dart:convert';

ModelResponseGetChapter modelResponseGetChapterFromJson(String str) => ModelResponseGetChapter.fromJson(json.decode(str));

String modelResponseGetChapterToJson(ModelResponseGetChapter data) => json.encode(data.toJson());

class ModelResponseGetChapter {
  final bool status;
  final String message;
  final List<DataChapter> data;

  ModelResponseGetChapter({
    required this.status,
    required this.message,
    required this.data,
  });

  ModelResponseGetChapter copyWith({
    bool? status,
    String? message,
    List<DataChapter>? data,
  }) =>
      ModelResponseGetChapter(
        status: status ?? this.status,
        message: message ?? this.message,
        data: data ?? this.data,
      );

  factory ModelResponseGetChapter.fromJson(Map<String, dynamic> json) => ModelResponseGetChapter(
    status: json["status"],
    message: json["message"],
    data: List<DataChapter>.from(json["data"].map((x) => DataChapter.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class DataChapter {
  final int id;
  final String uuid;
  final String number;
  final String title;
  final String content;
  final DateTime createdAt;

  DataChapter({
    required this.id,
    required this.uuid,
    required this.number,
    required this.title,
    required this.content,
    required this.createdAt,
  });

  DataChapter copyWith({
    int? id,
    String? uuid,
    String? number,
    String? title,
    String? content,
    DateTime? createdAt,
  }) =>
      DataChapter(
        id: id ?? this.id,
        uuid: uuid ?? this.uuid,
        number: number ?? this.number,
        title: title ?? this.title,
        content: content ?? this.content,
        createdAt: createdAt ?? this.createdAt,
      );

  factory DataChapter.fromJson(Map<String, dynamic> json) => DataChapter(
    id: json["id"],
    uuid: json["uuid"],
    number: json["number"],
    title: json["title"],
    content: json["content"],
    createdAt: DateTime.parse(json["created_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "uuid": uuid,
    "number": number,
    "title": title,
    "content": content,
    "created_at": "${createdAt.year.toString().padLeft(4, '0')}-${createdAt.month.toString().padLeft(2, '0')}-${createdAt.day.toString().padLeft(2, '0')}",
  };
}
