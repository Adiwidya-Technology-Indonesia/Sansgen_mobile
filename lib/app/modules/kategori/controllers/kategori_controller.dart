import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../model/book/book.dart';
import '../../../../provider/book.dart';
import '../../../data/books.dart';
import '../../../routes/app_pages.dart';

class KategoriController extends GetxController
    with StateMixin<List<DataBook>> {
  final BookProvider bookProvider;

  KategoriController({required this.bookProvider});

  final List<String> kategoriList = [
    'All',
    'Fiksi',
    'Non-Fiksi',
    'Edukasi',
    'Sejarah',
    'Teknologi',
    'Sains',
    'Biografi',
    'Komik',
  ];
  // final List<DataBook> bookList = List.generate(7, (index) => book);
  List<DataBook> bookList = <DataBook>[];
  final searchC = TextEditingController();
  var filterListKategori = <ModelFilter>[].obs;

  final isSearch = false.obs;

  void toDetails(DataBook book) {
    Get.toNamed(Routes.DETAIL, arguments: book);
  }

  @override
  void onInit() {
    findBooks();
    super.onInit();
  }

  Future findBooks() async {
    bookProvider.fetchBooks().then((result) {
      if (result.status == true) {
        filterListKategori.value = kategoriList
            .map(
              (e) => ModelFilter(title: e, isSelected: false.obs),
        )
            .toList();
        log(result.toString(), name: 'data model');
        bookList = result.data;
        change(bookList, status: RxStatus.success());
      } else {
        change([], status: RxStatus.empty());
        log('kosong', name: 'data kosong');
      }
    }, onError: (err) {
      change(null, status: RxStatus.error(err.toString()));
    });
  }

  Future onChangeFilter({required String filter}) async {
    if (filter == 'All') {
      await findBooks();
    }
    final onFilter = bookList.where((e) => e.category == filter).toList();
    change(onFilter, status: RxStatus.success());
  }

  void onChangeSearch({required String value, required RxBool isSearch}) {
    final onSearch = value.isEmpty
        ? bookList
        : bookList
        .where((element) => element.title.toLowerCase().contains(
      value.toLowerCase(),
    ))
        .toList();
    change(onSearch, status: RxStatus.success());
  }
}

class ModelFilter {
  final String title;
  Rx<bool> isSelected;

  ModelFilter({
    required this.title,
    required this.isSelected,
  });
}