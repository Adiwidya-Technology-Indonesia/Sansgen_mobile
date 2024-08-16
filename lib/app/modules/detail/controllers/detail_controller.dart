import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:sansgen/app/data/books.dart';
import 'package:sansgen/model/comment/request_post.dart';
import 'package:sansgen/provider/comment.dart';
import 'package:sansgen/provider/like.dart';

import '../../../../model/book/book.dart';
import '../../../../model/comment/user_comment.dart';
import '../../../../model/like/data_like.dart';
import '../component/content_chapter.dart';
import '../component/content_comment.dart';

class DetailController extends GetxController {
  final CommentProvider commentProvider;
  final LikeProvider likeProvider;

  DetailController({
    required this.commentProvider,
    required this.likeProvider,
  });

  late DataBook dataBook;
  final scrollController = ScrollController();
  final commentFormC = TextEditingController();
  final isLike = false.obs;
  final ratingCurrent = 0.0.obs;

  final listComments = <UserComment>[].obs;
  final listLike = <UserLike>[].obs;

  void likeState() => isLike.value = !isLike.value;

  @override
  void onInit() async {
    if (Get.arguments != null) {
      dataBook = Get.arguments;
      await getAllComment();
      await getAllLike();
      log(dataBook.uuid, name: 'idBook');
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
    RxList<UserComment> listComment,
    BuildContext ctx,
  ) {
    // listComment.sort((a, b) => a.time.compareTo(b.time));
    Get.bottomSheet(
      contentBottomSheetComment(
        context: ctx,
        listComment: listComment,
        scrollController: scrollController,
        controller: commentFormC,
        onTapSend: addComment,
      ),
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
    if (commentFormC.text == '') {
      return Get.snackbar('info', 'tulis komentar anda');
    }
    final request = ModelRequestPostComment(comment: commentFormC.text);
    await commentProvider
        .postCommentBook(uuidBook: dataBook.uuid, request: request)
        .then((v) async {
      await getAllComment();
      commentFormC.clear();
    }).onError((e, st) {
      Get.snackbar('info', 'gagal mengirim komentar');
    });
  }

  Future getAllComment() async {
    await commentProvider.fetchCommentByBookId(dataBook.uuid).then((v) {
      v.data.map(
        (e) => log(e.comment.toString(), name: 'data comment'),
      );
      if (v.data == []) {
        log('comment kosong', name: 'data comment');
        listComments.value = [];
      } else {
        log('comment ada', name: 'data comment');
        listComments.value = v.data;
      }
    }).onError((e, st) {
      listComments.value = [];
    });
  }

  Future addLike() async {
    await likeProvider.postLikeBook(uuidBook: dataBook.uuid).then((v) async {
      await getAllLike();
    }).onError((e, st) {
      Get.snackbar('info', 'gagal mengirim like');
    });
  }

  Future getAllLike() async {
    await likeProvider.fetchLikeByBookId(uuidBook: dataBook.uuid).then((v) {
      if (v.data == []) {
        log('comment kosong', name: 'data like');
        listLike.value = [];
      } else {
        log('comment ada', name: 'data like');
        listLike.value = v.data;
      }
    }).onError((e, st) {
      listLike.value = [];
    });
  }
}
