class ModelUser {
  final int id;
  final String uuid;
  final String email;
  final String name;
  final dynamic image;
  final dynamic dateOfBirth;
  final String? rangeAge;
  final String? gender;
  final dynamic hobby;
  final List<String> categories;
  final String token;

  ModelUser({
    required this.id,
    required this.uuid,
    required this.email,
    required this.name,
    required this.image,
    required this.dateOfBirth,
    required this.rangeAge,
    required this.gender,
    required this.hobby,
    required this.categories,
    required this.token,
  });

  ModelUser copyWith({
    int? id,
    String? uuid,
    String? email,
    String? name,
    String? image,
    dynamic dateOfBirth,
    String? rangeAge,
    String? gender,
    dynamic hobby,
    List<String>? categories,
    String? token,
  }) =>
      ModelUser(
        id: id ?? this.id,
        uuid: uuid ?? this.uuid,
        email: email ?? this.email,
        name: name ?? this.name,
        image: image ?? this.image,
        dateOfBirth: dateOfBirth ?? this.dateOfBirth,
        rangeAge: rangeAge ?? this.rangeAge,
        gender: gender ?? this.gender,
        hobby: hobby ?? this.hobby,
        categories: categories ?? this.categories,
        token: token ?? this.token,
      );

  factory ModelUser.fromJson(Map<String, dynamic> json) => ModelUser(
        id: json["id"] ?? 0,
        uuid: json["uuid"],
        email: json["email"],
        name: json["name"],
        image: json["image"] ?? "kosong",
        dateOfBirth: json["dateOfBirth"] ?? "kosong",
        rangeAge: json["rangeAge"] ?? "kosong",
        gender: json["gender"] ?? "kosong",
        hobby: json["hobby"] ?? "kosong",
        categories: json["categories"] == null
            ? []
            : List<String>.from(
                (json["categories"] as List<dynamic>).map(
                  (x) {
                    x as String;
                    return x;
                  },
                ).toList(),
              ),
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "uuid": uuid,
        "email": email,
        "name": name,
        "image": image,
        "dateOfBirth": dateOfBirth,
        "rangeAge": rangeAge,
        "gender": gender,
        "hobby": hobby,
        "categories": List<dynamic>.from(categories.map((x) => x)),
        "token": token,
      };
}
