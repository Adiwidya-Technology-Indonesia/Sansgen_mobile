// To parse this JSON data, do
//
//     final modelRequestPatchUser = modelRequestPatchUserFromJson(jsonString);

import 'dart:convert';

ModelRequestPatchUser modelRequestPatchUserFromJson(String str) => ModelRequestPatchUser.fromJson(json.decode(str));

String modelRequestPatchUserToJson(ModelRequestPatchUser data) => json.encode(data.toJson());

class ModelRequestPatchUser {
  final String? email;
  final String? name;
  final String? image;
  final DateTime? dateOfBirth;
  final String? rangeAge;
  final String? gender;
  final String? category;
  final String? hobby;

  ModelRequestPatchUser({
    this.email,
    this.name,
    this.image,
    this.dateOfBirth,
    this.rangeAge,
    this.gender,
    this.category,
    this.hobby,
  });

  ModelRequestPatchUser copyWith({
    String? email,
    String? name,
    String? image,
    DateTime? dateOfBirth,
    String? rangeAge,
    String? gender,
    String? category,
    String? hobby,
  }) =>
      ModelRequestPatchUser(
        email: email ?? this.email,
        name: name ?? this.name,
        image: image ?? this.image,
        dateOfBirth: dateOfBirth ?? this.dateOfBirth,
        rangeAge: rangeAge ?? this.rangeAge,
        gender: gender ?? this.gender,
        category: category ?? this.category,
        hobby: hobby ?? this.hobby,
      );

  factory ModelRequestPatchUser.fromJson(Map<String, dynamic> json) => ModelRequestPatchUser(
    email: json["email"],
    name: json["name"],
    image: json["image"],
    dateOfBirth: json["dateOfBirth"],
    rangeAge: json["rangeAge"],
    gender: json["gender"],
    category: json["category"],
    hobby: json["hobby"],
  );

  Map<String, dynamic> toJson() => {
    "email": email,
    "name": name,
    "image": image,
    "dateOfBirth": dateOfBirth,
    "rangeAge": rangeAge,
    "gender": gender,
    "category": category,
    "hobby": hobby,
  };
}
