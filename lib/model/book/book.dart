
class DataBook {
  final int id;
  final String uuid;
  final String title;
  final String image;
  final String synopsis;
  final String language;
  final String gender;
  final String rangeAge;
  final String category;
  final String writer;
  final String publisher;
  final int manyLikes;
  final double manyRatings;
  final int manyChapters;
  final int manyComments;

  DataBook({
    required this.id,
    required this.uuid,
    required this.title,
    required this.image,
    required this.synopsis,
    required this.language,
    required this.gender,
    required this.rangeAge,
    required this.category,
    required this.writer,
    required this.publisher,
    required this.manyLikes,
    required this.manyRatings,
    required this.manyChapters,
    required this.manyComments,
  });

  DataBook copyWith({
    int? id,
    String? uuid,
    String? title,
    String? image,
    String? synopsis,
    String? language,
    String? gender,
    String? rangeAge,
    String? category,
    String? writer,
    String? publisher,
    int? manyLikes,
    double? manyRatings,
    int? manyChapters,
    int? manyComments,
  }) =>
      DataBook(
        id: id ?? this.id,
        uuid: uuid ?? this.uuid,
        title: title ?? this.title,
        image: image ?? this.image,
        synopsis: synopsis ?? this.synopsis,
        language: language ?? this.language,
        gender: gender ?? this.gender,
        rangeAge: rangeAge ?? this.rangeAge,
        category: category ?? this.category,
        writer: writer ?? this.writer,
        publisher: publisher ?? this.publisher,
        manyLikes: manyLikes ?? this.manyLikes,
        manyRatings: manyRatings ?? this.manyRatings,
        manyChapters: manyChapters ?? this.manyChapters,
        manyComments: manyComments ?? this.manyComments,
      );

  factory DataBook.fromJson(Map<String, dynamic> json) => DataBook(
    id: json["id"],
    uuid: json["uuid"],
    title: json["title"],
    image: json["image"],
    synopsis: json["synopsis"],
    language: json["language"],
    gender: json["gender"],
    rangeAge: json["rangeAge"],
    category: json["category"],
    writer: json["writer"],
    publisher: json["publisher"],
    manyLikes: json["manyLikes"],
    manyRatings: json["manyRatings"],
    manyChapters: json["manyChapters"],
    manyComments: json["manyComments"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "uuid": uuid,
    "title": title,
    "image": image,
    "synopsis": synopsis,
    "language": language,
    "gender": gender,
    "rangeAge": rangeAge,
    "category": category,
    "writer": writer,
    "publisher": publisher,
    "manyLikes": manyLikes,
    "manyRatings": manyRatings,
    "manyChapters": manyChapters,
    "manyComments": manyComments,
  };
}
