import 'dart:convert';

ResponseRegisterModel responseRegisterModelFromJson(String str) =>
    ResponseRegisterModel.fromJson(json.decode(str));

String responseRegisterModelToJson(ResponseRegisterModel data) =>
    json.encode(data.toJson());

class ResponseRegisterModel {
  final bool success;
  final String message;
  final Data? data;

  ResponseRegisterModel({
    required this.success,
    required this.message,
    this.data,
  });

  factory ResponseRegisterModel.fromJson(Map<String, dynamic> json) {
    return ResponseRegisterModel(
      success: json['success'],
      message: json['message'],
      data: json['data'] != null ? Data.fromJson(json['data']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
      'data': data?.toJson(),
    };
  }
}

class Data {
  final String token;
  final String name;
  final String email;

  Data({
    required this.token,
    required this.name,
    required this.email,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      token: json['token'],
      name: json['name'],
      email: json['email'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'token': token,
      'name': name,
      'email': email,
    };
  }
}
