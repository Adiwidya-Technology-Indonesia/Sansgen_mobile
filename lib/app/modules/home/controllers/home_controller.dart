import 'dart:developer';

import 'package:get/get.dart';
import 'package:sansgen/model/user/response_user.dart';

import 'package:sansgen/provider/book.dart';

import '../../../../model/book/book.dart';
import '../../../../model/user/user.dart';
import '../../../../provider/best_for_you.dart';
import '../../../../provider/user.dart';
import '../../../routes/app_pages.dart';

class HomeController extends GetxController with StateMixin<ModelDataHome> {
  final BookProvider bookProvider;
  final UserProvider userProvider;
  final BestForYouProvider bestForYouProvider;

  HomeController({
    required this.bookProvider,
    required this.userProvider,
    required this.bestForYouProvider,
  });

  // final List<DataBook> bookList = List.generate(7, (index) => book);
  List<DataBook> bookList = <DataBook>[];

  void toDetails(DataBook book) {
    Get.toNamed(Routes.DETAIL, arguments: book);
  }

  @override
  void onInit() async {
    await fetchDataHome();
    super.onInit();
  }

  Future<void> fetchDataHome() async {
    // change(null, status: RxStatus.loading()); // Menampilkan status loading
    try {
      final resultPopuler = await bookProvider.fetchBooksPopuler();
      final resultInfoUser = await userProvider.fetchUserId();
      final resultBestForYou = await bestForYouProvider.fetchBooksBestForYou();
      // log(resultPopuler.toJson().toString(), name: 'resultPopuler.status');
      // log(resultInfoUser.toJson().toString(), name: 'resultInfoUser.status');
      // log(resultBestForYou.toJson().toString(), name: 'resultBestForYou.status');

      if (resultPopuler.status == true &&
          resultBestForYou.status == true &&
          resultInfoUser.data != ModelUser.fromJson({})) {
        final populerList = resultPopuler.data;
        final infoUser = resultInfoUser;
        final bestForYouList = resultBestForYou.data;

        // log(populerList.toString(), name: 'populerList');
        // log(infoUser.toString(), name: 'infoUser');
        // log(bestForYouList.toString(), name: 'bestForYouList');
        change(
          ModelDataHome(
            populer: populerList,
            bestForYou: bestForYouList,
            profil: infoUser.data!, // Ganti dengan data profil yang sesuai
            focus: {}, // Ganti dengandata focus yang sesuai
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
  final ModelUser profil;
  final Object focus;

  ModelDataHome({
    required this.populer,
    required this.bestForYou,
    required this.profil,
    required this.focus,
  });
}
