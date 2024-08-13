// To parse this JSON data, do
//
//     final modelBookById = modelBookByIdFromJson(jsonString);

import 'dart:convert';

import 'book.dart';

ModelBookById modelBookByIdFromJson(String str) => ModelBookById.fromJson(json.decode(str));

String modelBookByIdToJson(ModelBookById data) => json.encode(data.toJson());

class ModelBookById {
  final bool status;
  final String message;
  final DataBook data;

  ModelBookById({
    required this.status,
    required this.message,
    required this.data,
  });

  ModelBookById copyWith({
    bool? status,
    String? message,
    DataBook? data,
  }) =>
      ModelBookById(
        status: status ?? this.status,
        message: message ?? this.message,
        data: data ?? this.data,
      );

  factory ModelBookById.fromJson(Map<String, dynamic> json) => ModelBookById(
    status: json["status"],
    message: json["message"],
    data: DataBook.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data.toJson(),
  };
}
