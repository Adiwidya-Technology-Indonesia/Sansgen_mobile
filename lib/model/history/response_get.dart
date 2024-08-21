// To parse this JSON data, do
//
//     final modelResponseGetHistory = modelResponseGetHistoryFromJson(jsonString);

import 'dart:convert';

import '../book/book.dart';

ModelResponseGetHistory modelResponseGetHistoryFromJson(String str) => ModelResponseGetHistory.fromJson(json.decode(str));

String modelResponseGetHistoryToJson(ModelResponseGetHistory data) => json.encode(data.toJson());

class ModelResponseGetHistory {
  final bool status;
  final String message;
  final List<Datum> data;

  ModelResponseGetHistory({
    required this.status,
    required this.message,
    required this.data,
  });

  ModelResponseGetHistory copyWith({
    bool? status,
    String? message,
    List<Datum>? data,
  }) =>
      ModelResponseGetHistory(
        status: status ?? this.status,
        message: message ?? this.message,
        data: data ?? this.data,
      );

  factory ModelResponseGetHistory.fromJson(Map<String, dynamic> json) => ModelResponseGetHistory(
    status: json["status"],
    message: json["message"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  final int id;
  final String uuid;
  final String isFinished;
  final String lastChapter;
  final DataBook book;
  final List<Chapter> chapters;

  Datum({
    required this.id,
    required this.uuid,
    required this.isFinished,
    required this.lastChapter,
    required this.book,
    required this.chapters,
  });

  Datum copyWith({
    int? id,
    String? uuid,
    String? isFinished,
    String? lastChapter,
    DataBook? book,
    List<Chapter>? chapters,
  }) =>
      Datum(
        id: id ?? this.id,
        uuid: uuid ?? this.uuid,
        isFinished: isFinished ?? this.isFinished,
        lastChapter: lastChapter ?? this.lastChapter,
        book: book ?? this.book,
        chapters: chapters ?? this.chapters,
      );

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    uuid: json["uuid"],
    isFinished: json["isFinished"],
    lastChapter: json["lastChapter"],
    book: DataBook.fromJson(json["book"]),
    chapters: List<Chapter>.from(json["chapters"].map((x) => Chapter.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "uuid": uuid,
    "isFinished": isFinished,
    "lastChapter": lastChapter,
    "book": book.toJson(),
    "chapters": List<dynamic>.from(chapters.map((x) => x.toJson())),
  };
}

class Chapter {
  final int id;
  final String number;

  Chapter({
    required this.id,
    required this.number,
  });

  Chapter copyWith({
    int? id,
    String? number,
  }) =>
      Chapter(
        id: id ?? this.id,
        number: number ?? this.number,
      );

  factory Chapter.fromJson(Map<String, dynamic> json) => Chapter(
    id: json["id"],
    number: json["number"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "number": number,
  };
}
