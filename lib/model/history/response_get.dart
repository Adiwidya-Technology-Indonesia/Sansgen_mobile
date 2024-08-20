import 'dart:convert';

import 'package:sansgen/model/book/book.dart';

ModelResponseGetHistory modelResponseGetHistoryFromJson(String str) => ModelResponseGetHistory.fromJson(json.decode(str));

String modelResponseGetHistoryToJson(ModelResponseGetHistory data) => json.encode(data.toJson());

class ModelResponseGetHistory {
  final bool status;
  final String message;
  final List<DataHistory> data;

  ModelResponseGetHistory({
    required this.status,
    required this.message,
    required this.data,
  });

  ModelResponseGetHistory copyWith({
    bool? status,
    String? message,
    List<DataHistory>? data,
  }) =>
      ModelResponseGetHistory(
        status: status ?? this.status,
        message: message ?? this.message,
        data: data ?? this.data,
      );

  factory ModelResponseGetHistory.fromJson(Map<String, dynamic> json) => ModelResponseGetHistory(
    status: json["status"],
    message: json["message"],
    data: List<DataHistory>.from(json["data"].map((x) => DataHistory.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class DataHistory {
  final int id;
  final String uuid;
  final String isFinished;
  final String lastChapter;
  final DataBook book;
  final List<ChapterHistory> chapters;

  DataHistory({
    required this.id,
    required this.uuid,
    required this.isFinished,
    required this.lastChapter,
    required this.book,
    required this.chapters,
  });

  DataHistory copyWith({
    int? id,
    String? uuid,
    String? isFinished,
    String? lastChapter,
    DataBook? book,
    List<ChapterHistory>? chapters,
  }) =>
      DataHistory(
        id: id ?? this.id,
        uuid: uuid ?? this.uuid,
        isFinished: isFinished ?? this.isFinished,
        lastChapter: lastChapter ?? this.lastChapter,
        book: book ?? this.book,
        chapters: chapters ?? this.chapters,
      );

  factory DataHistory.fromJson(Map<String, dynamic> json) => DataHistory(
    id: json["id"],
    uuid: json["uuid"],
    isFinished: json["isFinished"],
    lastChapter: json["lastChapter"],
    book: DataBook.fromJson(json["book"]),
    chapters: List<ChapterHistory>.from(json["chapters"].map((x) => ChapterHistory.fromJson(x))),
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

class ChapterHistory {
  final int id;
  final String number;

  ChapterHistory({
    required this.id,
    required this.number,
  });

  ChapterHistory copyWith({
    int? id,
    String? number,
  }) =>
      ChapterHistory(
        id: id ?? this.id,
        number: number ?? this.number,
      );

  factory ChapterHistory.fromJson(Map<String, dynamic> json) => ChapterHistory(
    id: json["id"],
    number: json["number"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "number": number,
  };
}
