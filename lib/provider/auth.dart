import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';

import '../keys/api.dart';
import '../keys/env.dart';
import '../model/response_login.dart';

class AuthProvider extends GetConnect {
  final String baseURL = dotenv.get(KeysEnv.baseUrl);

  Future<ResponseLoginModel> login(String email, String password) async {
    final response = await post(
      KeysApi.login,
      {
        'email': email,
        'password': password,
      },
    );

    if (response.statusCode == 200) {
      return ResponseLoginModel.fromJson(response.body);
    } else {
      throw Exception('Failed to login');
    }
  }

  @override
  void onInit() {
    httpClient.baseUrl = baseURL;
  }
}
