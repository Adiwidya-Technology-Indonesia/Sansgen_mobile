import 'dart:convert';

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
  final String idBook;
  final List<Chapter> chapters;

  DataHistory({
    required this.id,
    required this.uuid,
    required this.isFinished,
    required this.lastChapter,
    required this.idBook,
    required this.chapters,
  });

  DataHistory copyWith({
    int? id,
    String? uuid,
    String? isFinished,
    String? lastChapter,
    String? idBook,
    List<Chapter>? chapters,
  }) =>
      DataHistory(
        id: id ?? this.id,
        uuid: uuid ?? this.uuid,
        isFinished: isFinished ?? this.isFinished,
        lastChapter: lastChapter ?? this.lastChapter,
        idBook: idBook ?? this.idBook,
        chapters: chapters ?? this.chapters,
      );

  factory DataHistory.fromJson(Map<String, dynamic> json) => DataHistory(
    id: json["id"],
    uuid: json["uuid"],
    isFinished: json["isFinished"],
    lastChapter: json["lastChapter"],
    idBook: json["idBook"],
    chapters: List<Chapter>.from(json["chapters"].map((x) => Chapter.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "uuid": uuid,
    "isFinished": isFinished,
    "lastChapter": lastChapter,
    "idBook": idBook,
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
