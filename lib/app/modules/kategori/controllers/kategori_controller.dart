import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../model/book/book.dart';
import '../../../../provider/book.dart';
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

  final genreList = <String>[
    'Laki-laki',
    'Perempuan',
  ];

  final genreCurrent = ''.obs;
  List<DataBook> bookList = <DataBook>[];
  final searchC = TextEditingController();
  var filterListKategori = <ModelFilter>[].obs;

  final isSearch = false.obs;

  void setGenre(String v) => genreCurrent.value = v;

  void toDetails(DataBook book) {
    Get.toNamed(Routes.DETAIL, arguments: {
      'dataBook': book,
      'indexDash': 1,
    });
  }

  @override
  void onInit() {
    findBooks();
    setGenre(genreList[0]);
    filterListKategori.value = kategoriList
        .map(
          (e) => ModelFilter(title: e, isSelected: false.obs),
        )
        .toList();
    filterListKategori[0].isSelected.value = true;
    super.onInit();
  }

  @override
  void onReady() {
    findBooks();
    setGenre(genreList[0]);
    filterListKategori.value = kategoriList
        .map(
          (e) => ModelFilter(title: e, isSelected: false.obs),
    )
        .toList();
    filterListKategori[0].isSelected.value = true;
    super.onReady();
  }

  Future findBooks() async {
    bookProvider.fetchBooks().then((result) {
      if (result.status == true) {
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

  void onChangeFilterGenre(String v) {
    final onFilter = bookList.where((e) => e.gender == v).toList();
    setGenre(v);
    change(onFilter, status: RxStatus.success());
  }

  void onChangeSearch({required String value, required RxBool isSearch}) {
    if (value.isNotEmpty) {
      isSearch.value = true;
    } else {
      isSearch.value = false;
      findBooks();
    }
    final onSearch = value.isEmpty
        ? bookList
        : bookList
            .where((element) => element.title.toLowerCase().contains(
                  value.toLowerCase(),
                ))
            .toList();
    change(onSearch, status: RxStatus.success());
  }

  void onChangeFilterCategory(int index) {
    // Toggle nilai isSelected untuk filter yang dipilih
    filterListKategori[index].isSelected.value =
        !filterListKategori[index].isSelected.value;

    // Jika 'All' dipilih, hapus pilihan pada filter lainnya
    if (index == 0 && filterListKategori[index].isSelected.value) {
      for (var i = 1; i < filterListKategori.length; i++) {
        filterListKategori[i].isSelected.value = false;
      }
    } else if (filterListKategori[index].isSelected.value) {
      // Jika filter selain 'All' dipilih, hapus pilihan pada 'All'
      filterListKategori[0].isSelected.value = false;
    }

    // Terapkan filter berdasarkan pilihan yangbaru
    final selectedFilters = filterListKategori
        .where((e) => e.isSelected.value)
        .map((e) => e.title)
        .toList();

    if (selectedFilters.contains('All')) {
      findBooks(); // Tampilkan semua buku jika 'All' dipilih
    } else {
      final filteredBooks = bookList
          .where((book) =>
              selectedFilters.contains(book.category) &&
              book.gender == genreCurrent.value)
          .toList();
      change(filteredBooks, status: RxStatus.success());
    }
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
