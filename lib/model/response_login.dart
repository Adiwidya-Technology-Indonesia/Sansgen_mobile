import 'dart:convert';

ResponseLoginModel responseLoginModelFromJson(String str) =>
    ResponseLoginModel.fromJson(json.decode(str));

String responseLoginModelToJson(ResponseLoginModel data) =>
    json.encode(data.toJson());

class ResponseLoginModel {
  final bool success;
  final String message;
  final DataLogin? data;

  ResponseLoginModel({
    required this.success,
    required this.message,
    required this.data,
  });

  factory ResponseLoginModel.fromJson(Map<String, dynamic> json) =>
      ResponseLoginModel(
        success: json["success"],
        message: json["message"],
        data: DataLogin.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data?.toJson(),
      };
}

class DataLogin {
  int id;
  String email;
  String name;
  dynamic image;
  dynamic dateOfBirth;
  dynamic rangeAge;
  dynamic gender;
  dynamic category;
  dynamic hobby;
  String rememberToken;

  DataLogin({
    required this.id,
    required this.email,
    required this.name,
    required this.image,
    required this.dateOfBirth,
    required this.rangeAge,
    required this.gender,
    required this.category,
    required this.hobby,
    required this.rememberToken,
  });

  factory DataLogin.fromJson(Map<String, dynamic> json) => DataLogin(
        id: json["id"],
        email: json["email"],
        name: json["name"],
        image: json["image"],
        dateOfBirth: json["dateOfBirth"],
        rangeAge: json["rangeAge"],
        gender: json["gender"],
        category: json["category"],
        hobby: json["hobby"],
        rememberToken: json["remember_token"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "name": name,
        "image": image,
        "dateOfBirth": dateOfBirth,
        "rangeAge": rangeAge,
        "gender": gender,
        "category": category,
        "hobby": hobby,
        "remember_token": rememberToken,
      };
}
