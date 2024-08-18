// To parse this JSON data, do
//
//     final modelResponsePostRedirectPayment = modelResponsePostRedirectPaymentFromJson(jsonString);

import 'dart:convert';

ModelResponsePostRedirectPayment modelResponsePostRedirectPaymentFromJson(String str) => ModelResponsePostRedirectPayment.fromJson(json.decode(str));

String modelResponsePostRedirectPaymentToJson(ModelResponsePostRedirectPayment data) => json.encode(data.toJson());

class ModelResponsePostRedirectPayment {
  final String token;
  final String? redirectUrl;

  ModelResponsePostRedirectPayment({
    required this.token,
    required this.redirectUrl,
  });

  ModelResponsePostRedirectPayment copyWith({
    String? token,
    String? redirectUrl,
  }) =>
      ModelResponsePostRedirectPayment(
        token: token ?? this.token,
        redirectUrl: redirectUrl ?? this.redirectUrl,
      );

  factory ModelResponsePostRedirectPayment.fromJson(Map<String, dynamic> json) => ModelResponsePostRedirectPayment(
    token: json["token"],
    redirectUrl: json["redirect_url"] ?? null,
  );

  Map<String, dynamic> toJson() => {
    "token": token,
    "redirect_url": redirectUrl,
  };
}
