import 'dart:developer';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:sansgen/model/book/book_by_id.dart';

import '../keys/api.dart';
import '../keys/env.dart';
import '../model/book/books_all.dart';

class BestForYouProvider extends GetConnect {
  // baseUrl
  final String baseURL = dotenv.get(KeysEnv.baseUrl);

  Future<ModelBooks> fetchBooksBestForYou() async {
    try {
      const String urlProduct = KeysApi.bestForYou;
      log(urlProduct, name: "data url Product");
      final response = await get(urlProduct);
      if (response.status.hasError) {
        log(response.toString(), name: 'data error');
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
    httpClient.baseUrl = baseURL;
    super.onInit();
  }
}
