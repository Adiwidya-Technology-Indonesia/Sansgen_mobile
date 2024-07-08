import 'package:get/get.dart';
import 'package:sansgen/app/modules/riwayat/views/belum_baca.dart';
import 'package:sansgen/app/modules/riwayat/views/sudah_baca.dart';

import '../../../../model/books.dart';
import '../../../data/books.dart';
import '../../../routes/app_pages.dart';

class RiwayatController extends GetxController {
  final currentIndex = 0.obs;
  void setCurrentIndex(int index) => currentIndex.value = index;
  get getSelectedIndex => currentIndex.value;

  final listPage = [
    const BelumSelesaiDiBaca(),
    const SudahSelesaiDiBaca(),
  ];

  final List<BookModel> bookList = List.generate(3, (index) => book);

  void toDetails(BookModel book) {
    Get.toNamed(Routes.DETAIL, arguments: book);
  }
}
