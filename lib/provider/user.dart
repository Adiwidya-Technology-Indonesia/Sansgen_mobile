import 'dart:developer';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:sansgen/model/user/response_user.dart';

import '../keys/api.dart';
import '../keys/env.dart';
import '../model/error.dart';
import '../model/user/request_patch_user.dart';
import '../services/prefs.dart';

class UserProvider extends GetConnect {
  // baseUrl
  final String baseURL = dotenv.get(KeysEnv.baseUrl);
  final PrefService _prefService = PrefService();

  Future<ModelResponseUser> fetchUserId() async {
    try {
      const String urlUserId = KeysApi.users + KeysApi.current;
      log(urlUserId, name: "data url Product");
      final response = await get(urlUserId);
      if (response.status.hasError) {
        log(response.toString(), name: 'response error');
        return Future.error(response);
        // return modelResponseErrorFromJson(response.bodyString!);
      } else {
        // log(response.bodyString!, name: 'data response');
        return modelResponseUserFromJson(response.bodyString!);
      }
    } catch (error) {
      log(error.toString(), name: "data error");
      rethrow;
    }
  }

  Future patchUserCurrent(ModelRequestPatchUser request) async {
    try {
      const String patchUserCurrent = KeysApi.users + KeysApi.current;
      log(patchUserCurrent, name: "data url Product");
      final response = await patch(
        patchUserCurrent,
        request.toJson(),
      );
      if (response.status.hasError) {
        log(response.toString(), name: 'data error');
        // return Future.error(response);
        return modelResponseErrorFromJson(response.bodyString!);
      } else {
        // log(response.bodyString!, name: 'data response');
        return modelResponseUserFromJson(response.bodyString!);
      }
    } catch (error) {
      log(error.toString(), name: "data error");
      rethrow;
    }
  }
  @override
  void onInit() {
    _prefService.prefInit();
    httpClient.addRequestModifier<dynamic>((request) {
      final token = _prefService.getUserToken;
      request.headers['Authorization'] = "Bearer $token";
      return request;
    });
    httpClient.baseUrl = baseURL;
    super.onInit();
  }
}
