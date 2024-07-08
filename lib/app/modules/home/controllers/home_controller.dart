import 'package:get/get.dart';
import 'package:sansgen/app/data/books.dart';

import '../../../../model/books.dart';
import '../../../routes/app_pages.dart';

class HomeController extends GetxController {
  final List<BookModel> bookList = List.generate(7, (index) => book);

  void toDetails(BookModel book) {
    Get.toNamed(Routes.DETAIL, arguments: book);
  }
}
