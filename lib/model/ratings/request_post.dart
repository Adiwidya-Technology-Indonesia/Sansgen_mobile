import 'dart:convert';

ModelRequestRateBook modelRequestRateBookFromJson(String str) => ModelRequestRateBook.fromJson(json.decode(str));

String modelRequestRateBookToJson(ModelRequestRateBook data) => json.encode(data.toJson());

class ModelRequestRateBook {
  final double rate;

  ModelRequestRateBook({
    required this.rate,
  });

  ModelRequestRateBook copyWith({
    double? rate,
  }) =>
      ModelRequestRateBook(
        rate: rate ?? this.rate,
      );

  factory ModelRequestRateBook.fromJson(Map<String, dynamic> json) => ModelRequestRateBook(
    rate: json["rate"]?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "rate": rate,
  };
}
