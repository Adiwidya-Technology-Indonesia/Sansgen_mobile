import 'dart:developer';

import 'package:get/get.dart';

// import 'package:sansgen/app/data/books.dart';
import 'package:sansgen/provider/book.dart';

import '../../../../model/book/book.dart';
import '../../../../provider/best_for_you.dart';
import '../../../routes/app_pages.dart';

class HomeController extends GetxController with StateMixin<ModelDataHome> {
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
    super.onInit();
  }

  Future<void> fetchDataHome() async {
    change(null, status: RxStatus.loading()); // Menampilkan status loading
    try {
      final resultPopuler = await bookProvider.fetchBooksPopuler();
      final resultBestForYou = await bestForYouProvider.fetchBooksBestForYou();

      if (resultPopuler.status == true && resultBestForYou.status == true) {
        final populerList = resultPopuler.data;
        final bestForYouList = resultBestForYou.data;

        change(
          ModelDataHome(
            populer: populerList,
            bestForYou: bestForYouList,
            profil: {}, // Ganti dengan data profil yang sesuai
            focul: {}, // Ganti dengandata focul yang sesuai
          ),
          status: RxStatus.success(),
        );
      } else {
        change(null, status: RxStatus.empty());
        log('Salah satu atau kedua permintaan gagal', name: 'data kosong');
      }
    } catch (err) {
      change(null, status: RxStatus.error(err.toString()));
    }
  }
}

class ModelDataHome {
  final List<DataBook> populer;
  final List<DataBook> bestForYou;
  final Object profil;
  final Object focul;

  ModelDataHome({
    required this.populer,
    required this.bestForYou,
    required this.profil,
    required this.focul,
  });
}
