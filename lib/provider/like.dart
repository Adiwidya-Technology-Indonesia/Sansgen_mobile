import 'dart:developer';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:sansgen/model/comment/request_post.dart';
import 'package:sansgen/model/comment/response_post.dart';

import '../keys/api.dart';
import '../keys/env.dart';
import '../model/error.dart';
import '../model/like/response_like.dart';
import '../services/prefs.dart';

class LikeProvider extends GetConnect {
  // baseUrl
  final String baseURL = dotenv.get(KeysEnv.baseUrl);
  final PrefService _prefService = PrefService();

  Future<ModelResponseGetLike> fetchLikeByBookId(String id) async {
    try {
      final String urlLikeByBookId = '${KeysApi.books}/$id/${KeysApi.likes}';
      log(urlLikeByBookId, name: "data url LikeByBookId");
      final response = await get(urlLikeByBookId);
      if (response.status.hasError) {
        log(response.toString(), name: 'response error');
        return Future.error(response);
        // return modelResponseErrorFromJson(response.bodyString!);
      } else {
        // log(response.bodyString!, name: 'data response');
        return modelResponseGetLikeFromJson(response.bodyString!);
      }
    } catch (error) {
      log(error.toString(), name: "data error");
      rethrow;
    }
  }

  Future postCommentBook({
    required String uuidBook,
    required ModelRequestPostComment request,
  }) async {
    try {
      final String urlPostCommentBook = '${KeysApi.books}/$uuidBook/comments';
      log(urlPostCommentBook, name: "data url Product");
      final response = await post(
        urlPostCommentBook,
        request.toJson(),
      );
      if (response.status.hasError) {
        log(response.statusText.toString(), name: 'data error');
        // return Future.error(response.bodyString.toString());
        return modelResponseErrorFromJson(response.bodyString!);
      } else {
        log(response.bodyString!, name: 'data response');
        return modelResponsePostCommentFromJson(response.bodyString!);
      }
    } catch (error) {
      log(error.toString(), name: "catch error");
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
