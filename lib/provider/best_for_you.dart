import 'dart:developer';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:sansgen/model/book/book_by_id.dart';

import '../keys/api.dart';
import '../keys/env.dart';
import '../model/book/books_all.dart';
import '../services/prefs.dart';

class BestForYouProvider extends GetConnect {
  // baseUrl
  final String baseURL = dotenv.get(KeysEnv.baseUrl);
  final PrefService _prefService = PrefService();

  Future<ModelBooks> fetchBooksBestForYou() async {
    try {
      const String urlBestForYou = KeysApi.bestForYou;
      log(urlBestForYou, name: "data url bestForYou");
      final response = await get(urlBestForYou);
      if (response.status.hasError) {
        log(response.toString(), name: 'response error');
        return Future.error(response);
      } else {
        // log(response.bodyString!, name: 'data response');
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
