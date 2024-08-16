import 'dart:developer';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:sansgen/model/book/book_by_id.dart';

import '../keys/api.dart';
import '../keys/env.dart';
import '../model/book/books_all.dart';

class BookProvider extends GetConnect {
  // baseUrl
  final String baseURL = dotenv.get(KeysEnv.baseUrl);

  Future<ModelBookById> fetchIdBooks(String id) async {
    try {
      final String urlIdBooks = '${KeysApi.books}/$id';
      log(urlIdBooks, name: "data url IdBooks");
      final response = await get(urlIdBooks);
      if (response.status.hasError) {
        log(response.toString(), name: 'response error');
        return Future.error(response);
      } else {
        // log(response.bodyString!, name: 'data response');
        return modelBookByIdFromJson(response.bodyString!);
      }
    } catch (error) {
      log(error.toString(), name: "data error");
      rethrow;
    }
  }

  Future<ModelBooks> fetchBooks() async {
    try {
      const String urlBooks = KeysApi.books;
      log(urlBooks, name: "data url Books");
      final response = await get(urlBooks);
      if (response.status.hasError) {
        log(response.toString(), name: 'response error fetchBooks');
        return Future.error(response);
      } else {
        // log(response.bodyString!, name: 'data response');
        return booksModelFromJson(response.bodyString!);
      }
    } catch (error) {
      log(error.toString(), name: "catch error fetchBooks");
      rethrow;
    }
  }

  Future<ModelBooks> fetchBooksPopuler() async {
    try {
      const String urlBooksPopuler = KeysApi.books + KeysApi.populer;
      log(urlBooksPopuler, name: "data url book populer");
      final response = await get(urlBooksPopuler);
      if (response.status.hasError) {
        log(response.toString(), name: 'response error populer');
        return Future.error(response);
      } else {
        // log(response.bodyString!, name: 'data response');
        return booksModelFromJson(response.bodyString!);
      }
    } catch (error) {
      log(error.toString(), name: "catch error populer");
      rethrow;
    }
  }

  @override
  void onInit() {
    httpClient.baseUrl = baseURL;
    super.onInit();
  }
}
