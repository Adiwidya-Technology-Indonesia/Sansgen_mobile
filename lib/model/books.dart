import 'dart:convert';

BookModel bookModelFromJson(String str) => BookModel.fromJson(json.decode(str));

String bookModelToJson(BookModel data) => json.encode(data.toJson());

class BookModel {
  String title;
  String image;
  String sinopsis;
  String language;
  String gender;
  String rangeAge;
  String category;
  String writer;
  String publisher;
  double manyRatings;
  int manyLike;
  int manyComment;
  int manyChapter;

  BookModel({
    required this.title,
    required this.image,
    required this.sinopsis,
    required this.language,
    required this.gender,
    required this.rangeAge,
    required this.category,
    required this.writer,
    required this.publisher,
    required this.manyRatings,
    required this.manyLike,
    required this.manyComment,
    required this.manyChapter,
  });

  factory BookModel.fromJson(Map<String, dynamic> json) => BookModel(
        title: json["title"],
        image: json["image"],
        sinopsis: json["sinopsis"],
        language: json["language"],
        gender: json["gender"],
        rangeAge: json["rangeAge"],
        category: json["category"],
        writer: json["writer"],
        publisher: json["publisher"],
        manyRatings: json["manyRatings"]?.toDouble(),
        manyLike: json["manyLike"],
        manyComment: json["manyComment"],
        manyChapter: json["manyChapter"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "image": image,
        "sinopsis": sinopsis,
        "language": language,
        "gender": gender,
        "rangeAge": rangeAge,
        "category": category,
        "writer": writer,
        "publisher": publisher,
        "manyRatings": manyRatings,
        "manyLike": manyLike,
        "manyComment": manyComment,
        "manyChapter": manyChapter,
      };
}
