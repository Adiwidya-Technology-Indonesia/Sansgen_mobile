import 'dart:developer';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';

import '../keys/api.dart';
import '../keys/env.dart';
import '../model/error.dart';
import '../model/login/request_login.dart';
import '../model/login/response_login.dart';
import '../model/register/model_request_register.dart';
import '../model/register/model_response_register.dart';

class AuthProvider extends GetConnect {
  final String baseURL = dotenv.get(KeysEnv.baseUrl);

  Future<ModelResponseLogin> authLogin(ModelReqestLogin request) async {
    try {
      final response = await post(
        KeysApi.login,
        request.toJson(),
      );
      if (response.status.hasError) {
        log(response.body.toString(), name: 'login error');
        throw Exception('Failed to login');
        // return modelResponseErrorFromJson(response.bodyString!);
      } else {
        return modelResponseLoginFromJson(response.bodyString!);
      }
    } catch (error) {
      log(error.toString(), name: "auth regis error");
      rethrow;
    }
  }

  Future authRegister(ModelReqestRegister request) async {
    try {
      const String urlRegiser = KeysApi.register;
      log(urlRegiser, name: "url register");
      final response = await post(
        urlRegiser,
        request.toJson(),
      );
      if (response.status.hasError) {
        log(response.toString(), name: 'regis error');
        // return Future.error(response);
        return modelResponseErrorFromJson(response.bodyString!);
      } else {
        log(response.bodyString!, name: 'data response');
        return modelResponseRegisterFromJson(response.bodyString!);
      }
    } catch (error) {
      log(error.toString(), name: "auth regis error");
      rethrow;
    }
  }

  @override
  void onInit() {
    log(baseURL, name: 'baseURL');
    httpClient.baseUrl = baseURL;
  }
}
