import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sansgen/app/data/books.dart';

import '../../../../model/book/book.dart';
import '../component/content_chapter.dart';
import '../component/content_comment.dart';

class DetailController extends GetxController {
  late DataBook dataBook;
  final scrollController = ScrollController();
  final isLike = false.obs;

  void likeState() => isLike.value = !isLike.value;

  void tapViewBottomSheetChapter(List<int> listChapter, BuildContext context) {
    Get.bottomSheet(
      contentBottomSheetChapter(context, listChapter, dataBook),
    );
  }

  void tapViewBottomSheetComment(
    List<ModelComment> listComment,
    BuildContext context,
  ) {
    listComment.sort((a, b) => a.time.compareTo(b.time));
    Get.bottomSheet(
      contentBottomSheetComment(context, listComment, scrollController),
      ignoreSafeArea: false,
      isScrollControlled: true,
    ).then((_) { // Setelah bottom sheet ditampilkan
      // Gulir ke bawah
      scrollController.animateTo(
        scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    });
  }

  @override
  void onInit() {
    if (Get.arguments != null) {
      dataBook = Get.arguments;
    } else {
      dataBook = book;
    }
    super.onInit();
  }

  List<ModelComment> comments = [
    ModelComment(
      id: '1',
      comment: 'Komentar yang sangat bagus!',
      user: 'Pengguna A',
      time: DateTime.now()
          .subtract(const Duration(minutes: 15)), // 15 menit yang lalu
    ),
    ModelComment(
      id: '2',
      comment: 'Saya setuju dengan komentar di atas.',
      user: 'Pengguna B',
      time:
          DateTime.now().subtract(const Duration(hours: 2)), // 2 jam yang lalu
    ),
    ModelComment(
      id: '3',
      comment: 'Ini sangat membantu, terima kasih!',
      user: 'Pengguna C',
      time: DateTime.now().subtract(const Duration(days: 1)), // Kemarin
    ),
    ModelComment(
      id: '4',
      comment: 'Saya punya pertanyaan tentang ini...',
      user: 'Pengguna D',
      time:
          DateTime.now().subtract(const Duration(days: 3)), // 3 hari yang lalu
    ),
    ModelComment(
      id: '5',
      comment: 'Artikel yang menarik!',
      user: 'Pengguna E',
      time: DateTime.now()
          .subtract(const Duration(days: 7)), // Seminggu yang lalu
    ),
    ModelComment(
      id: '6',
      comment: 'Saya akan membagikan ini dengan teman-teman saya.',
      user: 'Pengguna F',
      time: DateTime.now()
          .subtract(const Duration(days: 10)), // 10 hari yang lalu
    ),
    ModelComment(
      id: '7',
      comment: 'Terima kasih atas informasinya.',
      user: 'Pengguna G',
      time: DateTime.now()
          .subtract(const Duration(minutes: 5)), // 5 menit yang lalu
    ),
  ];
}

class ModelComment {
  final String? id;
  final String comment;
  final String user;
  final DateTime time;

  ModelComment({
    this.id,
    required this.comment,
    required this.user,
    required this.time,
  });
}
