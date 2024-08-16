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
  // final DateTime createdAt;
  final int manyLikes;
  final int manyRatings;
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
    // required this.createdAt,
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
    // DateTime? createdAt,
    int? manyLikes,
    int? manyRatings,
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
        // createdAt: createdAt ?? this.createdAt,
        manyLikes: manyLikes ?? this.manyLikes,
        manyRatings: manyRatings ?? this.manyRatings,
        manyChapters: manyChapters ?? this.manyChapters,
        manyComments: manyComments ?? this.manyComments,
      );

  factory DataBook.fromJson(Map<String, dynamic> json) => DataBook(
        id: json["id"] ?? 0,
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
        // createdAt: DateTime.parse(json["created_at"]),
        manyLikes: json["manyLikes"] ?? 0,
        manyRatings: json["manyRatings"] ?? 0,
        manyChapters: json["manyChapters"] ?? 0,
        manyComments: json["manyComments"] ?? 0,
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
        // "created_at":
        //     "${createdAt.year.toString().padLeft(4, '0')}-${createdAt.month.toString().padLeft(2, '0')}-${createdAt.day.toString().padLeft(2, '0')}",
        "manyLikes": manyLikes,
        "manyRatings": manyRatings,
        "manyChapters": manyChapters,
        "manyComments": manyComments,
      };
}
