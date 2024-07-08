import 'package:get/get.dart';

import '../../../../model/books.dart';
import '../../../data/books.dart';
import '../../../routes/app_pages.dart';

class KategoriController extends GetxController {
  final List<String> kategoriList = [
    'Fiksi',
    'Non-Fiksi',
    'Edukasi',
    'Sejarah',
    'Teknologi',
    'Sains',
    'Biografi',
    'Komik',
  ];

  final List<BookModel> bookList = List.generate(7, (index) => book);

  void toDetails(BookModel book) {
    Get.toNamed(Routes.DETAIL, arguments: book);
  }
}
