import 'dart:async';
import 'dart:developer';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:sansgen/app/modules/riwayat/views/belum_baca.dart';
import 'package:sansgen/app/modules/riwayat/views/sudah_baca.dart';
import 'package:sansgen/utils/ext_string.dart';

import '../../../../keys/env.dart';
import '../../../../model/book/books.dart';
import '../../../../provider/history.dart';
import '../../../../provider/book.dart';
import '../../../routes/app_pages.dart';

class RiwayatController extends GetxController with StateMixin<ModelHistory> {
  final HistoryProvider historyProvider;
  final BookProvider bookProvider;

  RiwayatController({
    required this.historyProvider,
    required this.bookProvider,
  });

  final String baseURL = dotenv.get(KeysEnv.baseUrl);

  final currentIndex = 0.obs;

  void setCurrentIndex(int index) => currentIndex.value = index;

  get getSelectedIndex => currentIndex.value;

  final listPage = [
    const BelumSelesaiDiBaca(),
    const SudahSelesaiDiBaca(),
  ];

  final listBookFinish = <DataBook>[].obs;
  final listBookNotFinish = <DataBook>[].obs;

  void toDetails(DataBook dataBook) {
    Get.toNamed(
      Routes.DETAIL,
      arguments: {
        'dataBook': dataBook,
        'indexDash': 2,
      },
    );
  }

  @override
  void onInit() async {
    getAllHistory();
    super.onInit();
  }

  @override
  void onReady() {
    getAllHistory();
    super.onReady();
  }

  Future getIdBook(String idBook) async {
    await bookProvider.fetchIdBooks(idBook);
  }

  Future getAllHistory() async {
    historyProvider.fetchHistory().then((event) async {
      if (event.data == []) {
        final dataEmpty = ModelHistory(
          listBookFinish: listBookFinish,
          listBookNotFinish: listBookNotFinish,
        );
        change(dataEmpty, status: RxStatus.empty());
      }

      final bookSelesai = event.data.where((e) => e.isFinished == '1').map((v) {
        return v.book.copyWith(image: v.book.image!.formattedUrl);
      }).toList();

      final bookBelumSelesai =
          event.data.where((e) => e.isFinished == '0').map((v) {
        return v.book.copyWith(image: v.book.image!.formattedUrl);
      }).toList();

      listBookFinish.value = bookSelesai;
      listBookNotFinish.value = bookBelumSelesai;
      log(bookSelesai.toString(), name: 'bookSelesai');
      log(bookBelumSelesai.toString(), name: 'bookBelumSelesai');

      final dataState = ModelHistory(
        listBookFinish: listBookFinish,
        listBookNotFinish: listBookNotFinish,
      );
      change(dataState, status: RxStatus.success());
    }).onError((e, st) {
      change(null, status: RxStatus.error(e.toString()));
    });
  }
}

class ModelHistory {
  final RxList<DataBook> listBookFinish;
  final RxList<DataBook> listBookNotFinish;

  ModelHistory({
    required this.listBookFinish,
    required this.listBookNotFinish,
  });
}
