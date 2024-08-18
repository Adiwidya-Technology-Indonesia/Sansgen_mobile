import 'dart:developer';

import 'package:get/get.dart';

import 'package:sansgen/provider/book.dart';
import 'package:sansgen/provider/focus.dart';

import '../../../../model/book/book.dart';
import '../../../../model/focus/data_focus.dart';
import '../../../../model/user/user.dart';
import '../../../../provider/best_for_you.dart';
import '../../../../provider/user.dart';
import '../../../routes/app_pages.dart';

class HomeController extends GetxController with StateMixin<ModelDataHome> {
  final BookProvider bookProvider;
  final BestForYouProvider bestForYouProvider;
  final UserProvider userProvider;
  final FocusProvider focusProvider;

  HomeController({
    required this.bookProvider,
    required this.bestForYouProvider,
    required this.userProvider,
    required this.focusProvider,
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
    try {
      late List<DataBook> populerList;
      late List<DataBook> bestForYouList;
      late ModelUser infoUser;
      late DataFocus infoFocus;

      final resultPopuler = await bookProvider.fetchBooksPopuler();
      final resultInfoUser = await userProvider.fetchUserId();
      final resultBestForYou = await bestForYouProvider.fetchBooksBestForYou();
      final resultFocus = await focusProvider.fetchFocusByUser();

      if (resultPopuler.status != true) {
        populerList = [];
        log('Permintaan buku populer gagal', name: 'data kosong');
      } else {
        populerList = resultPopuler.data;
        log(populerList.map((e) => e.toJson()).toString(), name: 'populerList');
      }
      if (resultBestForYou.status != true) {
        bestForYouList = [];
        log('Permintaan buku terbaik untuk Anda gagal', name: 'data kosong');
      } else {
        bestForYouList = resultBestForYou.data;
        log(
          bestForYouList.map((e) => e.toJson()).toString(),
          name: 'bestForYouList',
        );
      }
      if (resultInfoUser.data == null) {
        infoUser = ModelUser.fromJson({});
        log('Permintaan informasi pengguna gagal', name: 'data kosong');
      } else {
        infoUser = resultInfoUser.data!;
        log(infoUser.toJson().toString(), name: 'infoUser');
      }
      if (resultFocus.data == null) {
        infoFocus = DataFocus.fromJson({});
      } else {
        infoFocus = resultFocus.data!;
      }
      if (populerList.isEmpty &&
          bestForYouList.isEmpty &&
          infoUser == ModelUser.fromJson({})) {
        change(null, status: RxStatus.empty());
        log('Semua data kosong', name: 'data kosong');
      }
      change(
        ModelDataHome(
          populer: populerList,
          bestForYou: bestForYouList,
          profil: infoUser,
          focus: infoFocus,
        ),
        status: RxStatus.success(),
      );
    } catch (err) {
      log(err.toString(), name: 'pesan error home controller');
      change(null, status: RxStatus.error(err.toString()));
    }
  }
}

class ModelDataHome {
  final List<DataBook> populer;
  final List<DataBook> bestForYou;
  final ModelUser profil;
  final DataFocus focus;

  ModelDataHome({
    required this.populer,
    required this.bestForYou,
    required this.profil,
    required this.focus,
  });
}