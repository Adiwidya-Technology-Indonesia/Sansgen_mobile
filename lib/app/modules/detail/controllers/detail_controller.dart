import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:sansgen/app/data/books.dart';
import 'package:sansgen/model/comment/request_post.dart';
import 'package:sansgen/provider/comment.dart';

import '../../../../model/book/book.dart';
import '../../../../model/comment/user_comment.dart';
import '../component/content_chapter.dart';

class DetailController extends GetxController
    with StateMixin<List<UserComment>> {
  final CommentProvider commentProvider;

  DetailController({required this.commentProvider});

  late DataBook dataBook;
  final scrollController = ScrollController();
  final commentFormC = TextEditingController();
  final isLike = false.obs;
  final ratingCurrent = 0.0.obs;

  List<UserComment> comments = [];

  void likeState() => isLike.value = !isLike.value;

  @override
  void onInit() {
    if (Get.arguments != null) {
      dataBook = Get.arguments;
      getAllComment();
    } else {
      dataBook = book;
    }
    super.onInit();
  }

  void tapViewBottomSheetChapter(List<int> listChapter, BuildContext context) {
    Get.bottomSheet(
      contentBottomSheetChapter(context, listChapter, dataBook),
    );
  }

  void tapViewRating() {
    Get.defaultDialog(
      title: 'Berikan rating anda',
      onConfirm: () {},
      content: Obx(
        () => RatingBar.builder(
          initialRating: ratingCurrent.value,
          minRating: 1,
          direction: Axis.horizontal,
          allowHalfRating: true,
          itemSize: 28,
          itemCount: 5,
          itemPadding: const EdgeInsets.symmetric(horizontal: 1),
          itemBuilder: (context, _) => const Icon(
            Icons.star,
            color: Colors.amber,
          ),
          onRatingUpdate: (rating) {
            ratingCurrent.value = rating;
            log(rating.toString(), name: 'rating');
          },
        ),
      ),
    );
  }

  void tapViewBottomSheetComment(
    List<UserComment> listComment,
      Widget content,
  ) {
    // listComment.sort((a, b) => a.time.compareTo(b.time));
    Get.bottomSheet(
      content,
      ignoreSafeArea: false,
      isScrollControlled: true,
    ).then((_) {
      // Setelah bottom sheet ditampilkan
      // Gulir ke bawah
      scrollController.animateTo(
        scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    });
  }

  Future addRating() async {}

    Future addComment() async {
    final request = ModelRequestPostComment(comment: commentFormC.text);
    await commentProvider
        .postCommentBook(uuidBook: dataBook.uuid, request: request)
        .then((v) {
      getAllComment();
    }).onError((e, st) {
      Get.snackbar('info', 'gagal mengirim komentar');
    });
  }

  Future getAllComment() async {
    await commentProvider.fetchCommentByBookId(dataBook.uuid).then((v) {
      if (v.data != []) {
        change([], status: RxStatus.empty());
      } else {
        change(v.data, status: RxStatus.success());
      }
    }).onError((e, st) {
      change(null, status: RxStatus.error('$e & $st'));
    });
  }
}
