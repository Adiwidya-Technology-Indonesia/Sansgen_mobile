import 'dart:developer';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import '../keys/api.dart';
import '../keys/env.dart';
import '../model/chapter/response_get.dart';
import '../services/prefs.dart';

class ChapterProvider extends GetConnect {
  // baseUrl
  final String baseURL = dotenv.get(KeysEnv.baseUrl);
  final PrefService _prefService = PrefService();

  Future<ModelResponseGetChapter> fetchChapter(String idBook) async {
    try {
      final String urlChapter = '${KeysApi.books}/$idBook${KeysApi.chapters}';
      log(urlChapter, name: "data url Chapter");
      final response = await get(urlChapter);
      log(response.statusCode.toString(), name: 'response status code');
      if (response.status.hasError) {
        log(response.bodyString.toString(), name: 'response Chapter error');
        return Future.error(response);
        // } else if (response.statusCode == 404) {
        //   return modelDataEmptyFromJson(response.bodyString!);
      } else {
        log(response.bodyString!, name: 'data response Chapter');
        return modelResponseGetChapterFromJson(response.bodyString!);
      }
    } catch (error) {
      log(error.toString(), name: "catch error Chapter");
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
