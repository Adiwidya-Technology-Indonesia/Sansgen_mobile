// To parse this JSON data, do
//
//     final modelResponseErrorRegister = modelResponseErrorRegisterFromJson(jsonString);

import 'dart:convert';

ModelResponseErrorRegister modelResponseErrorRegisterFromJson(String str) => ModelResponseErrorRegister.fromJson(json.decode(str));

String modelResponseErrorRegisterToJson(ModelResponseErrorRegister data) => json.encode(data.toJson());

class ModelResponseErrorRegister {
  final bool success;
  final String message;
  final DataErrorRegis data;

  ModelResponseErrorRegister({
    required this.success,
    required this.message,
    required this.data,
  });

  ModelResponseErrorRegister copyWith({
    bool? success,
    String? message,
    DataErrorRegis? data,
  }) =>
      ModelResponseErrorRegister(
        success: success ?? this.success,
        message: message ?? this.message,
        data: data ?? this.data,
      );

  factory ModelResponseErrorRegister.fromJson(Map<String, dynamic> json) => ModelResponseErrorRegister(
    success: json["success"],
    message: json["message"],
    data: DataErrorRegis.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": data.toJson(),
  };
}

class DataErrorRegis {
  final List<String> email;

  DataErrorRegis({
    required this.email,
  });

  DataErrorRegis copyWith({
    List<String>? email,
  }) =>
      DataErrorRegis(
        email: email ?? this.email,
      );

  factory DataErrorRegis.fromJson(Map<String, dynamic> json) => DataErrorRegis(
    email: List<String>.from(json["email"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "email": List<dynamic>.from(email.map((x) => x)),
  };
}
