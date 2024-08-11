import 'dart:convert';

import 'data_response_register.dart';

ModelResponseRegister modelResponseRegisterFromJson(String str) =>
    ModelResponseRegister.fromJson(json.decode(str));

String modelResponseRegisterToJson(ModelResponseRegister data) =>
    json.encode(data.toJson());

class ModelResponseRegister {
  final bool success;
  final String message;
  final DataResponseRegister? data;

  ModelResponseRegister({
    required this.success,
    required this.message,
    this.data,
  });

  factory ModelResponseRegister.fromJson(Map<String, dynamic> json) {
    return ModelResponseRegister(
      success: json['success'],
      message: json['message'],
      data: json['data'] != null ? DataResponseRegister.fromJson(json['data']) : null,
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
