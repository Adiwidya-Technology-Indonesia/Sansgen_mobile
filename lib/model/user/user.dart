
class ModelUser {
  final int id;
  final String uuid;
  final String email;
  final String name;
  final dynamic image;
  final dynamic dateOfBirth;
  final dynamic rangeAge;
  final dynamic gender;
  final dynamic category;
  final dynamic hobby;
  final String token;
  final List<dynamic> history;

  ModelUser({
    required this.id,
    required this.uuid,
    required this.email,
    required this.name,
    required this.image,
    required this.dateOfBirth,
    required this.rangeAge,
    required this.gender,
    required this.category,
    required this.hobby,
    required this.token,
    required this.history,
  });

  ModelUser copyWith({
    int? id,
    String? uuid,
    String? email,
    String? name,
    dynamic image,
    dynamic dateOfBirth,
    dynamic rangeAge,
    dynamic gender,
    dynamic category,
    dynamic hobby,
    String? token,
    List<dynamic>? history,
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
        category: category ?? this.category,
        hobby: hobby ?? this.hobby,
        token: token ?? this.token,
        history: history ?? this.history,
      );

  factory ModelUser.fromJson(Map<String, dynamic> json) => ModelUser(
    id: json["id"],
    uuid: json["uuid"],
    email: json["email"],
    name: json["name"],
    image: json["image"],
    dateOfBirth: json["dateOfBirth"],
    rangeAge: json["rangeAge"],
    gender: json["gender"],
    category: json["category"],
    hobby: json["hobby"],
    token: json["token"],
    history: List<dynamic>.from(json["history"].map((x) => x)),
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
    "category": category,
    "hobby": hobby,
    "token": token,
    "history": List<dynamic>.from(history.map((x) => x)),
  };
}
