import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sansgen/utils/ext_string.dart';

import '../../../../model/book/books.dart';
import '../../../../provider/book.dart';
import '../../../../provider/category.dart';
import '../../../routes/app_pages.dart';

class KategoriController extends GetxController
    with StateMixin<List<DataBook>> {
  final BookProvider bookProvider;
  final CategoryProvider categoryProvider;

  KategoriController({
    required this.bookProvider,
    required this.categoryProvider,
  });

  final RefreshController refreshController =
      RefreshController(initialRefresh: false);

  final kategoriList = ['All'].obs;

  // final genreList = <String>[
  //   'Laki-laki',
  //   'Perempuan',
  // ];

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
  void onInit() async {
    await findBooks();
    await findCategory();
    // setGenre(genreList[0]);
    filterListKategori.value = kategoriList
        .map(
          (e) => ModelFilter(title: e, isSelected: false.obs),
        )
        .toList();
    filterListKategori[0].isSelected.value = true;
    super.onInit();
  }

  Future<bool> getPassengerCategory({bool isRefresh = false}) async {
    if (isRefresh) {
      await findBooks();
      await findCategory(); // Pindahkan dan tambahkan await di sini
      // setGenre(genreList[0]);
      filterListKategori.value = kategoriList
          .map(
            (e) => ModelFilter(title: e, isSelected: false.obs),
          )
          .toList();
      filterListKategori[0].isSelected.value = true;
    } else {
      return false;
    }
    return true;
  }

  Future findBooks() async {
    bookProvider.fetchBooks().then((result) {
      if (result.status == true) {
        log(result.toString(), name: 'data model');
        bookList = result.data.map((e) {
          return e.copyWith(image: e.image!.formattedUrl);
        }).toList();
        change(bookList, status: RxStatus.success());
      } else {
        change([], status: RxStatus.empty());
        log('kosong', name: 'data kosong');
      }
    }, onError: (err) {
      change(null, status: RxStatus.error(err.toString()));
    });
  }

  Future findCategory() async {
    categoryProvider.fetchCategory().then((result) {
      if (result.status == true) {
        log(result.categories.map((e) => e.name).toList().toString(),
            name: 'data categories');
        // Mengambil nama kategori dan menambahkannya ke kategoriList
        final categories = result.categories.map((e) => e.name).toList();
        kategoriList.value = ['All', ...categories];
      } else {
        log('kosong', name: 'data kosong');
      }
    }, onError: (err) {
      kategoriList.value = ['All'];
    });
  }

  // void onChangeFilterGenre(String v) {
  //   final onFilter = bookList.where((e) => e.gender == v).toList();
  //   setGenre(v);
  //   change(onFilter, status: RxStatus.success());
  // }

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
            .where((element) =>
                element.title.toLowerCase().contains(value.toLowerCase()) ||
                element.synopsis.toLowerCase().contains(value.toLowerCase()) ||
                element.publisher.toLowerCase().contains(value.toLowerCase()) ||
                element.writer.toLowerCase().contains(value.toLowerCase()) ||
                element.gender.toLowerCase().contains(value.toLowerCase()))
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

class ModelCategoryPage {
  final List<DataBook> books;
  final List<String> categories;

  ModelCategoryPage({required this.books, required this.categories});
}
