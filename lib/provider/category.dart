import 'dart:developer';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';

import '../keys/api.dart';
import '../keys/env.dart';
import '../model/category/response_get.dart';

class CategoryProvider extends GetConnect {
  // baseUrl
  final String baseURL = dotenv.get(KeysEnv.baseUrl);

  Future<ModelResponseGetCategory> fetchCategory() async {
    try {
      const String urlCategory = KeysApi.category;
      log(urlCategory, name: "data url Category");
      final response = await get(urlCategory);
      if (response.status.hasError) {
        log(response.toString(), name: 'response error fetchCategory');
        return Future.error(response);
      } else {
        // log(response.bodyString!, name: 'data response');
        return modelResponseGetCategoryFromJson(response.bodyString!);
      }
    } catch (error) {
      log(error.toString(), name: "catch error fetchCategory");
      rethrow;
    }
  }

  @override
  void onInit() {
    httpClient.baseUrl = baseURL + KeysApi.api;
    super.onInit();
  }
}
