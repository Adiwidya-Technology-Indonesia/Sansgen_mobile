
import '../book/book.dart';

class DataHistory {
  final int id;
  final String uuid;
  final String isFinished;
  final String lastChapter;
  final DataBook book;
  final List<Chapter> chapters;

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
    List<Chapter>? chapters,
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
