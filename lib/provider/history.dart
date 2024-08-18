import 'dart:developer';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:sansgen/model/history/response_get.dart';

import '../keys/api.dart';
import '../keys/env.dart';
import '../services/prefs.dart';

class HistoryProvider extends GetConnect {
  // baseUrl
  final String baseURL = dotenv.get(KeysEnv.baseUrl);
  final PrefService _prefService = PrefService();

  Future<ModelResponseGetHistory> fetchHistory() async {
    try {
      const String urlHistory = KeysApi.history;
      log(urlHistory, name: "data url History");
      final response = await get(urlHistory);
      log(response.statusCode.toString(), name: 'response status code');
      if (response.status.hasError) {
        log(response.bodyString.toString(), name: 'response History error');
        return Future.error(response);
      // } else if (response.statusCode == 404) {
      //   return modelDataEmptyFromJson(response.bodyString!);
      } else {
        log(response.bodyString!, name: 'data response History');
        return modelResponseGetHistoryFromJson(response.bodyString!);
      }
    } catch (error) {
      log(error.toString(), name: "catch error History");
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
