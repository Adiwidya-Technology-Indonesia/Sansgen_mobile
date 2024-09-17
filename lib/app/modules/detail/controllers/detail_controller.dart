import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:sansgen/provider/book.dart';
import 'package:sansgen/provider/user.dart';

import '../../../../model/comment/request_post.dart';
import '../../../../model/history/response_by_id_book.dart';
import '../../../../model/ratings/request_post.dart';
import '../../../../provider/comment.dart';
import '../../../../provider/history.dart';
import '../../../../provider/like.dart';
import '../../../../provider/rate.dart';
import '../../../../services/prefs.dart';
import '../../../../model/book/book.dart';
import '../../../data/books.dart';
import '../component/content_chapter.dart';
import '../component/content_comment.dart';

class DetailController extends GetxController with StateMixin<ModelDataDetail> {
  final CommentProvider commentProvider;
  final LikeProvider likeProvider;
  final RatingProvider ratingProvider;
  final BookProvider bookProvider;
  final UserProvider userProvider;
  final HistoryProvider historyProvider;

  DetailController({
    required this.commentProvider,
    required this.likeProvider,
    required this.ratingProvider,
    required this.bookProvider,
    required this.userProvider,
    required this.historyProvider,
  });

  final prefServices = PrefService();

  final isPremium = false.obs;

  late DataIdBook dataBook;
  final scrollController = ScrollController();
  final commentFormC = TextEditingController();
  final isLikeState = false.obs;
  final ratingCurrent = 0.0.obs;

  final listComments = <Comment>[].obs;
  final listLike = <Like>[].obs;
  final listChapter = <Chapter>[].obs;
  final averageRate = 0.0.obs;
  final indexDashboard = 0.obs;

  RxList<int> readChapterIds = <int>[].obs; // Gunakan ID chapter,

  void backToDashboard() {
    Get.back();
  }

  @override
  void onInit() async {
    if (Get.arguments != null) {
      log('Get argument ada', name: 'onInit');
      dataBook = Get.arguments['dataBook'];
      indexDashboard.value = Get.arguments['indexDash'];
      await prefServices.prefInit();
      await fetchDataDetail(); // Panggil fungsi untuk mengambil semua data
      await fetchReadChapters();
      log(dataBook.uuid, name: 'idBook');
    } else {
      dataBook = book;
      // ... kode lainnya ...
    }
    super.onInit();
  }

  Future<void> fetchReadChapters() async {
    await historyProvider.fetchHistoryByIdBook(dataBook.uuid).then((response) {
      if (response.statusCode == 200) {
        final allHistory =
            modelResponseHistoryByIdBookFromJson(response.bodyString!);
        log(response.bodyString.toString(), name: 'response history chapter');
        readChapterIds.value =
            allHistory.data.chapters!.map((e) => e.id).toList();
      } else {
        readChapterIds.value = [];
      }
    });
  }

  void tapViewBottomSheetChapter(
      List<Chapter> listChapter, BuildContext context) {
    Get.bottomSheet(
      contentBottomSheetChapter(
        context: context,
        listChapter: listChapter,
        isPremium: isPremium.value,
        dataBook: dataBook,
        readChapterIds: readChapterIds,
      ),
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
    RxList<Comment> listComment,
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
    try {
      await ratingProvider.postRatingBook(
        uuidBook: dataBook.uuid,
        request: request,
      );
      // Perbarui averageRate di state
      final currentData = state; // Ambil state saat ini
      if (currentData != null) {
        await getAllRating(); // Perbarui averageRate
        change(
          currentData.copyWith(averageRate: averageRate.value),
          status: RxStatus.success(),
        );
      }
    } catch (e) {
      Get.snackbar('info', 'Anda sudah memberikan Rating');
    }
  }

  Future addComment() async {
    if (commentFormC.text == '') {
      return Get.snackbar('info', 'tulis komentar anda');
    }
    final request = ModelRequestPostComment(comment: commentFormC.text);
    try {
      await commentProvider.postCommentBook(
        uuidBook: dataBook.uuid,
        request: request,
      );
      // Perbarui listComments di state
      final currentData = state;
      if (currentData != null) {
        await getAllComment(); // Perbarui listComments
        change(
          currentData.copyWith(comments: listComments),
          status: RxStatus.success(),
        );
        commentFormC.clear();
      }
    } catch (e) {
      Get.snackbar('info', 'gagal mengirim komentar');
    }
  }

  Future addLike() async {
    try {
      await likeProvider.postLikeBook(uuidBook: dataBook.uuid);
      // Perbarui listLikes dan isLikeState di state
      final currentData = state;
      if (currentData != null) {
        await getAllLike(); // Perbarui listLikes dan isLikeState
        change(
          currentData.copyWith(likes: listLike, isLiked: isLikeState.value),
          status: RxStatus.success(),
        );
      }
    } catch (e) {
      Get.snackbar('info', 'gagal mengirim like');
    }
  }

  Future getAllComment() async {
    await bookProvider.fetchIdBooks(dataBook.uuid).then((v) {
      v.data.comments.map(
        (e) => log(e.comment.toString(), name: 'data comment'),
      );
      if (v.data.comments == []) {
        log('comment kosong', name: 'data comment');
        listComments.value = [];
      } else {
        log('comment ada', name: 'data comment');
        listComments.value = v.data.comments;
      }
    }).onError((e, st) {
      listComments.value = [];
    });
  }

  Future getAllLike() async {
    await bookProvider.fetchIdBooks(dataBook.uuid).then((v) {
      if (v.data.likes == []) {
        log('like kosong', name: 'data like');
        listLike.value = [];
      } else {
        log('like ada', name: 'data like');
        listLike.value = v.data.likes;
        final idUser = prefServices.getUserUuid;
        final isLike = v.data.likes.where((e) => e.user.uuid == idUser);
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
    await bookProvider.fetchIdBooks(dataBook.uuid).then((v) {
      if (v.data.manyRatings == 0) {
        log('comment kosong', name: 'data like');
        averageRate.value = 0.0;
      } else {
        log('comment ada', name: 'data like');
        averageRate.value = v.data.averageRate!;
      }
    }).onError((e, st) {
      listLike.value = [];
    });
  }

  Future getAllChapter() async {
    await bookProvider.fetchIdBooks(dataBook.uuid).then((v) {
      if (v.status == false) {
        log('comment kosong', name: 'data listChapter');
        listChapter.value = [];
      } else {
        log('comment ada', name: 'data listChapter');
        listChapter.value = v.data.chapters;
      }
    }).onError((e, st) {
      listLike.value = [];
    });
  }

  Future getUserLogin() async {
    await userProvider.fetchUserId().then((v) {
      if (v.data != null && v.data!.isPremium == '1') {
        log('kosong', name: 'data isPremium');
        isPremium.value = true;
      } else {
        log('ada', name: 'data isPremium');
        isPremium.value = false;
      }
    }).onError((e, st) {
      isPremium.value = false;
    });
  }

  Future<void> fetchDataDetail() async {
    try {
      change(null, status: RxStatus.loading()); // Set status loading

      final resultIdBook =
          await bookProvider.fetchIdBooks(dataBook.uuid);
      final resultUser = await userProvider.fetchUserId();

      // Proses data komentar
      if (resultIdBook.data.comments == []) {
        log('comment kosong', name: 'data comment');
        listComments.value = [];
      } else {
        log('comment ada', name: 'data comment');
        listComments.value = resultIdBook.data.comments;
      }

      // Proses data like
      if (resultIdBook.data.likes == []) {
        log('like kosong', name: 'data like');
        listLike.value = [];
      } else {
        log('like ada', name: 'data like');
        listLike.value = resultIdBook.data.likes;
        final idUser = prefServices.getUserUuid;
        final isLike = resultIdBook.data.likes.where((e) => e.user.uuid == idUser);
        isLikeState.value = isLike.isNotEmpty;
      }

      // Proses data rating
      if (resultIdBook.data.manyRatings == 0) {
        log('rating kosong', name: 'data rating');
        averageRate.value = 0.0;
      } else {
        log('rating ada', name: 'data rating');
        averageRate.value = resultIdBook.data.averageRate!;
      }

      // Proses data chapter
      if (resultIdBook.data.chapters == []) {
        log('chapter kosong', name: 'data listChapter');
        listChapter.value = [];
      } else {
        log('chapter ada', name: 'data listChapter');
        listChapter.value = resultIdBook.data.chapters;
      }

      // Proses data pengguna
      if (resultUser.data != null && resultUser.data!.isPremium == '1') {
        log('premium', name: 'data isPremium');
        isPremium.value = true;
      } else {
        log('tidak premium', name: 'data isPremium');
        isPremium.value = false;
      }

      // Buat objek ModelDataDetail dan update state
      final dataDetail = ModelDataDetail(
        comments: listComments,
        likes: listLike,
        averageRate: averageRate.value,
        chapters: listChapter,
        isPremium: isPremium.value,
        isLiked: isLikeState.value,
      );
      change(dataDetail, status: RxStatus.success()); // Set status success
    } catch (err) {
      log(err.toString(), name: 'pesan error detail controller');
      change(null, status: RxStatus.error(err.toString())); // Set status error
    }
  }
}

// Model data untuk DetailController (dengan tambahan isLiked)
class ModelDataDetail {
  final RxList<Comment> comments;
  final RxList<Like> likes;
  final double averageRate;
  final RxList<Chapter> chapters;
  final bool isPremium;
  final bool isLiked; // Tambahkan properti isLiked

  ModelDataDetail({
    required this.comments,
    required this.likes,
    required this.averageRate,
    required this.chapters,
    required this.isPremium,
    required this.isLiked, // Inisialisasi isLiked
  });

  // Tambahkan metode copyWith untuk memperbarui state
  ModelDataDetail copyWith({
    RxList<Comment>? comments,
    RxList<Like>? likes,
    double? averageRate,
    RxList<Chapter>? chapters,
    bool? isPremium,
    bool? isLiked,
  }) {
    return ModelDataDetail(
      comments: comments ?? this.comments,
      likes: likes ?? this.likes,
      averageRate: averageRate ?? this.averageRate,
      chapters: chapters ?? this.chapters,
      isPremium: isPremium ?? this.isPremium,
      isLiked: isLiked ?? this.isLiked,
    );
  }
}
