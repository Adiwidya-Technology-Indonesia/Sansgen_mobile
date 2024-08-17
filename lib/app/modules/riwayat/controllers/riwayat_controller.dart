import 'dart:async';

import 'package:get/get.dart';
import 'package:sansgen/app/modules/riwayat/views/belum_baca.dart';
import 'package:sansgen/app/modules/riwayat/views/sudah_baca.dart';

import '../../../../model/book/book.dart';
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
      arguments: dataBook,
    );
  }

  @override
  void onInit() async {
    getAllHistory();
    super.onInit();
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
      final bookSelesai =
          event.data.where((e) => e.isFinished == 'true').map((v) async {
        final book = await bookProvider.fetchIdBooks(v.idBook);
        return book.data;
      }).toList();

      final bookBelumSelesai =
          event.data.where((e) => e.isFinished == 'false').map((v) async {
        final book = await bookProvider.fetchIdBooks(v.idBook);
        return book.data;
      }).toList();

      listBookFinish.value = await Future.wait(bookSelesai);
      listBookNotFinish.value = await Future.wait(bookBelumSelesai);

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

