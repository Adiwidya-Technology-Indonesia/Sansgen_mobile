import 'dart:convert';
import 'dart:developer';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';

import '../keys/api.dart';
import '../keys/env.dart';
import '../model/response_login.dart';
import '../model/response_register.dart';

class AuthProvider extends GetConnect {
  final String baseURL = dotenv.get(KeysEnv.baseUrl);

  Future<ResponseLoginModel> authLogin(String email, String password) async {
    final response = await post(
      KeysApi.login,
      {
        'email': email,
        'password': password,
      },
    );

    if (response.status.hasError) {
      log(response.body.toString(), name: 'login error');
      throw Exception('Failed to login');
    } else {
      return ResponseLoginModel.fromJson(jsonDecode(response.bodyString!));
    }
  }

  Future<ResponseRegisterModel> authRegister(
    String name,
    String email,
    String password,
  ) async {
    // try {
    const String urlRegiser = KeysApi.register;
    log(urlRegiser, name: "url register");
    final response = await post(
      urlRegiser,
      {
        'name': name,
        'email': email,
        'password': password,
      },
    );
    if (response.status.hasError) {
      log(response.toString(), name: 'regis error');
      return Future.error(response);
    } else {
      log(response.bodyString!, name: 'data response');
      return ResponseRegisterModel.fromJson(jsonDecode(response.bodyString!));
    }
    // } catch (error) {
    //   log(error.toString(), name: "auth regis error");
    //   throw 'Error getting products: $error';
    // }
  }

  @override
  void onInit() {
    log(baseURL, name: 'baseURL');
    httpClient.baseUrl = baseURL;
  }
}
