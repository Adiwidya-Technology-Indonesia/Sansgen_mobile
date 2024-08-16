import 'dart:developer';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';

import '../keys/api.dart';
import '../keys/env.dart';
import '../model/book/books_all.dart';
import '../model/empty.dart';
import '../services/prefs.dart';

class BestForYouProvider extends GetConnect {
  // baseUrl
  final String baseURL = dotenv.get(KeysEnv.baseUrl);
  final PrefService _prefService = PrefService();

  Future fetchBooksBestForYou() async {
    try {
      const String urlBestForYou = KeysApi.books + KeysApi.bestForYou;
      log(urlBestForYou, name: "data url bestForYou");
      final response = await get(urlBestForYou);
      log(response.statusCode.toString(), name: 'response status code');
      if (response.status.hasError) {
        log(response.bodyString.toString(), name: 'response bestForYou error');
        return Future.error(response);
      } else if (response.statusCode == 404) {
        return modelDataEmptyFromJson(response.bodyString!);
      } else {
        log(response.bodyString!, name: 'data response');
        return booksModelFromJson(response.bodyString!);
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
