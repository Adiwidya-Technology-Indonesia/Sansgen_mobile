import 'dart:developer';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:sansgen/model/user/response_get.dart';

import '../keys/api.dart';
import '../keys/env.dart';
import '../model/user/logout.dart';
import '../model/user/request_patch_user.dart';
import '../services/prefs.dart';

class UserProvider extends GetConnect {
  // baseUrl
  final String baseURL = dotenv.get(KeysEnv.baseUrl);
  final PrefService _prefService = PrefService();

  Future<ModelResponseUser> fetchUserId() async {
    try {
      const String urlUserId = KeysApi.users + KeysApi.current;
      log(urlUserId, name: "data url User Id");
      final response = await get(urlUserId);
      if (response.status.hasError) {
        log(response.bodyString.toString(), name: 'response urlUserId error');
        return Future.error(response);
        // return modelResponseErrorFromJson(response.bodyString!);
      } else {
        // log(response.bodyString!, name: 'data response');
        return modelResponseUserFromJson(response.bodyString!);
      }
    } catch (error) {
      log(error.toString(), name: "catch user error");
      rethrow;
    }
  }

  Future patchOnBoarding(ModelRequestPatchUser request) async {
    try {
      const String patchUserCurrent = KeysApi.users + KeysApi.current;
      log(baseURL, name: "data baseURL");
      log(patchUserCurrent, name: "data url patchUserCurrent");
      log(request.toOnBoarding().toString(), name: "data request");
      final response = await patch(
        patchUserCurrent,
        request.toOnBoarding(),
      );
      if (response.status.hasError) {
        log(response.toString(), name: 'data error patchUserCurrent');
        if (response.statusCode == 401) {
          // Handle unauthorized error (misalnya, logout pengguna)
          throw Exception('Unauthorized');
        } else if (response.statusCode == 500) {
          // Handle internal server error
          throw Exception('Internal Server Error');
        } else {
          // Handle other error codes
          throw Exception('Failed to update user: ${response.statusCode}');
        }
      } else {
        return modelResponseUserFromJson(response.bodyString!);
      }
    } catch (error) {
      log(error.toString(), name: "catch error patchUserCurrent");
      rethrow;
    }
  }

  Future patchInfoPribadi(ModelRequestPatchUser request) async {
    try {
      const String patchUserCurrent = KeysApi.users + KeysApi.current;
      log(baseURL, name: "data baseURL");
      log(patchUserCurrent, name: "data url patchUserCurrent");
      final response = await patch(
        patchUserCurrent,
        request.toInfoPribadi(),
      );
      if (response.status.hasError) {
        log(response.bodyString.toString(), name: 'data error patchUserCurrent');
        if (response.statusCode == 401) {
          // Handle unauthorized error (misalnya, logout pengguna)
          throw Exception('Unauthorized');
        } else if (response.statusCode == 500) {
          // Handle internal server error
          throw Exception('Internal Server Error');
        } else {
          // Handle other error codes
          throw Exception('Failed to update user: ${response.statusCode}');
        }
      } else {
        return modelResponseUserFromJson(response.bodyString!);
      }
    } catch (error) {
      log(error.toString(), name: "catch error patchUserCurrent");
      rethrow;
    }
  }

  Future patchReference(ModelRequestPatchUser request) async {
    try {
      const String patchUserCurrent = KeysApi.users + KeysApi.current;
      log(baseURL, name: "data baseURL");
      log(patchUserCurrent, name: "data url patchUserCurrent");
      final response = await patch(
        patchUserCurrent,
        request.toReference(),
      );
      if (response.status.hasError) {
        log(response.toString(), name: 'data error patchUserCurrent');
        if (response.statusCode == 401) {
          // Handle unauthorized error (misalnya, logout pengguna)
          throw Exception('Unauthorized');
        } else if (response.statusCode == 500) {
          // Handle internal server error
          throw Exception('Internal Server Error');
        } else {
          // Handle other error codes
          throw Exception('Failed to update user: ${response.statusCode}');
        }
      } else {
        return modelResponseUserFromJson(response.bodyString!);
      }
    } catch (error) {
      log(error.toString(), name: "catch error patchUserCurrent");
      rethrow;
    }
  }


  Future logOut() async {
    try {
      final response = await post(
        KeysApi.users + KeysApi.logout,
        {},
      );
      if (response.status.hasError) {
        log(response.body.toString(), name: 'login error');
        throw Exception('Failed to login');
        // return modelResponseErrorFromJson(response.bodyString!);
      } else {
        return modelResponsePostLogOutFromJson(response.bodyString!);
      }
    } catch (error) {
      log(error.toString(), name: "auth regis error");
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
    httpClient.baseUrl = baseURL + KeysApi.api;
    super.onInit();
  }
}
