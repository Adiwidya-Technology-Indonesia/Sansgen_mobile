import 'dart:developer';

import 'package:get/get.dart';

// import 'package:sansgen/app/data/books.dart';
import 'package:sansgen/provider/book.dart';

import '../../../../model/book/book.dart';
import '../../../../provider/best_for_you.dart';
import '../../../routes/app_pages.dart';

class HomeController extends GetxController with StateMixin<List<DataBook>> {
  final BookProvider bookProvider;
  final BestForYouProvider bestForYouProvider;

  HomeController({
    required this.bookProvider,
    required this.bestForYouProvider,
  });

  // final List<DataBook> bookList = List.generate(7, (index) => book);
  List<DataBook> bookList = <DataBook>[];

  void toDetails(DataBook book) {
    Get.toNamed(Routes.DETAIL, arguments: book);
  }

  @override
  void onInit() {
    findBooks();
    super.onInit();
  }

  Future findBooks() async {
    bookProvider.fetchBooks().then((result) {
      if (result.status == true) {
        log(result.toString(), name: 'data model');
        bookList = result.data;
        change(bookList, status: RxStatus.success());
      } else {
        change([], status: RxStatus.empty());
        log('kosong', name: 'data kosong');
      }
    }, onError: (err) {
      change(null, status: RxStatus.error(err.toString()));
    });
  }
}
