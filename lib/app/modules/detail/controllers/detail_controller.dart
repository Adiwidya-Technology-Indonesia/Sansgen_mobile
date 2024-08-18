import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:sansgen/model/chapter/response_get.dart';

import '../../../../app/data/books.dart';
import '../../../../model/comment/request_post.dart';
import '../../../../model/ratings/request_post.dart';
import '../../../../provider/comment.dart';
import '../../../../provider/like.dart';
import '../../../../services/prefs.dart';
import '../../../../model/book/book.dart';
import '../../../../model/comment/user_comment.dart';
import '../../../../model/like/data_like.dart';
import '../../../../provider/rate.dart';
import '../../../../provider/chapter.dart';
import '../component/content_chapter.dart';
import '../component/content_comment.dart';

class DetailController extends GetxController {
  final CommentProvider commentProvider;
  final LikeProvider likeProvider;
  final RatingProvider ratingProvider;
  final ChapterProvider chapterProvider;

  DetailController({
    required this.commentProvider,
    required this.likeProvider,
    required this.ratingProvider,
    required this.chapterProvider,
  });

  final prefServices = PrefService();

  late DataBook dataBook;
  final scrollController = ScrollController();
  final commentFormC = TextEditingController();
  final isLikeState = false.obs;
  final ratingCurrent = 0.0.obs;

  final listComments = <UserComment>[].obs;
  final listLike = <UserLike>[].obs;
  final listChapter = <DataChapter>[].obs;
  final averageRate = 0.0.obs;

// void likeState() => isLike.value = !isLike.value;

  @override
  void onInit() async {
    if (Get.arguments != null) {
      dataBook = Get.arguments;
      await getAllComment();
      await getAllLike();
      await getAllRating();
      await getAllChapter();
      await prefServices.prefInit();
      log(dataBook.uuid, name: 'idBook');
    } else {
      dataBook = book;
    }
    super.onInit();
  }

  void tapViewBottomSheetChapter(List<DataChapter> listChapter, BuildContext context) {
    Get.bottomSheet(
      contentBottomSheetChapter(context, listChapter, dataBook),
    );
  }

  void tapViewRating() {
    Get.defaultDialog(
      title: 'Berikan rating anda',
      onConfirm: () async {
        await addRating(ratingCurrent.value);
        Get.back();
      },
      textConfirm: 'Berikan',
      onCancel: Get.back,
      textCancel: 'Batal',
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

  Future addRating(double rate) async {
    final request = ModelRequestPostRate(rate: rate);
    await ratingProvider
        .postRatingBook(
      uuidBook: dataBook.uuid,
      request: request,
    )
        .then((v) async {
      await getAllRating();
    }).onError((e, st) {
      Get.snackbar('info', 'Anda sudah memberikan Rating');
    });
  }

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
        final idUser = prefServices.getUserUuid;
        final isLike = v.data.where((e) => e.user.uuid == idUser);
        if (isLike.isEmpty) {
          isLikeState.value = false;
        } else {
          isLikeState.value = true;
        }
      }
    }).onError((e, st) {
      listLike.value = [];
    });
  }

  Future getAllRating() async {
    await ratingProvider.fetchRatingByBookId(uuidBook: dataBook.uuid).then((v) {
      if (v.data.ratings == []) {
        log('comment kosong', name: 'data like');
        averageRate.value = 0.0;
      } else {
        log('comment ada', name: 'data like');
        averageRate.value = v.data.averageRate;
      }
    }).onError((e, st) {
      listLike.value = [];
    });
  }

  Future getAllChapter() async {
    await chapterProvider.fetchChapter(dataBook.uuid).then((v) {
      if (v.status == false) {
        log('comment kosong', name: 'data listChapter');
        listChapter.value = [];
      } else {
        log('comment ada', name: 'data listChapter');
        listChapter.value = v.data;
      }
    }).onError((e, st) {
      listLike.value = [];
    });
  }
}
