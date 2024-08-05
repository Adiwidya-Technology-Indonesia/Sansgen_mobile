import 'package:get/get.dart';
import 'package:sansgen/app/data/books.dart';

import '../../../../model/book/book.dart';
import '../../../routes/app_pages.dart';

class HomeController extends GetxController {
  final List<DataBook> bookList = List.generate(7, (index) => book);

  void toDetails(DataBook book) {
    Get.toNamed(Routes.DETAIL, arguments: book);
  }
}
