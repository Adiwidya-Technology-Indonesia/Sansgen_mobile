import 'package:get/get.dart';

import '../../../../model/book/book.dart';
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

  final List<DataBook> bookList = List.generate(7, (index) => book);

  void toDetails(DataBook book) {
    Get.toNamed(Routes.DETAIL, arguments: book);
  }
}
