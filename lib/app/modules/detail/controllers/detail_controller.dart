import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:sansgen/provider/user.dart';

import '../../../../model/chapter/data_chapter.dart';
import '../../../../model/comment/request_post.dart';
import '../../../../model/history/response_by_id_book.dart';
import '../../../../model/ratings/request_post.dart';
import '../../../../provider/comment.dart';
import '../../../../provider/history.dart';
import '../../../../provider/like.dart';
import '../../../../services/prefs.dart';
import '../../../../model/book/book.dart';
import '../../../../model/comment/user_comment.dart';
import '../../../../model/like/data_like.dart';
import '../../../../provider/rate.dart';
import '../../../../provider/chapter.dart';
import '../component/content_chapter.dart';
import '../component/content_comment.dart';

class DetailController extends GetxController with StateMixin<ModelDataDetail> {
  final CommentProvider commentProvider;
  final LikeProvider likeProvider;
  final RatingProvider ratingProvider;
  final ChapterProvider chapterProvider;
  final UserProvider userProvider;
  final HistoryProvider historyProvider;

  DetailController({
    required this.commentProvider,
    required this.likeProvider,
    required this.ratingProvider,
    required this.chapterProvider,
    required this.userProvider,
    required this.historyProvider,
  });

  final prefServices = PrefService();

  final isPremium = false.obs;

  late DataBook dataBook;
  final scrollController = ScrollController();
  final commentFormC = TextEditingController();
  final isLikeState = false.obs;
  final ratingCurrent = 0.0.obs;

  final listComments = <UserComment>[].obs;
  final listLike = <UserLike>[].obs;
  final listChapter = <DataChapter>[].obs;
  final averageRate = 0.0.obs;
  final indexDashboard = 0.obs;

  RxList<int> readChapterIds = <int>[].obs; // Gunakan ID chapter,

// void likeState() => isLike.value = !isLike.value;
  void backToDashboard() {
    Get.back();
    // Get.offAllNamed(
    //   Routes.DASHBOARD,
    //   arguments: indexDashboard.value,
    // );
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
      // ... kode lainnya ...
    }
    super.onInit();
  }

  Future<void> fetchReadChapters() async {
    await historyProvider.fetchHistoryByIdBook(dataBook.uuid).then((response) {
      if (response.statusCode == 200) {
        final allHistory =
            modelResponseHistoryByIdBookFromJson(response.bodyString!);
        readChapterIds.value =
            allHistory.data.chapters.map((e) => e.id).toList();
      } else {
        readChapterIds.value = [];
      }
    });
  }

  void tapViewBottomSheetChapter(
      List<DataChapter> listChapter, BuildContext context) {
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

  Future getAllLike() async {
    await likeProvider.fetchLikeByBookId(uuidBook: dataBook.uuid).then((v) {
      if (v.data == []) {
        log('like kosong', name: 'data like');
        listLike.value = [];
      } else {
        log('like ada', name: 'data like');
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

      final resultComments =
          await commentProvider.fetchCommentByBookId(dataBook.uuid);
      final resultLikes =
          await likeProvider.fetchLikeByBookId(uuidBook: dataBook.uuid);
      final resultRatings =
          await ratingProvider.fetchRatingByBookId(uuidBook: dataBook.uuid);
      final resultChapters = await chapterProvider.fetchChapter(dataBook.uuid);
      final resultUser = await userProvider.fetchUserId();

      // Proses data komentar
      if (resultComments.data == []) {
        log('comment kosong', name: 'data comment');
        listComments.value = [];
      } else {
        log('comment ada', name: 'data comment');
        listComments.value = resultComments.data;
      }

      // Proses data like
      if (resultLikes.data == []) {
        log('like kosong', name: 'data like');
        listLike.value = [];
      } else {
        log('like ada', name: 'data like');
        listLike.value = resultLikes.data;
        final idUser = prefServices.getUserUuid;
        final isLike = resultLikes.data.where((e) => e.user.uuid == idUser);
        isLikeState.value = isLike.isNotEmpty;
      }

      // Proses data rating
      if (resultRatings.data.ratings == []) {
        log('rating kosong', name: 'data rating');
        averageRate.value = 0.0;
      } else {
        log('rating ada', name: 'data rating');
        averageRate.value = resultRatings.data.averageRate;
      }

      // Proses data chapter
      if (resultChapters.status == false) {
        log('chapter kosong', name: 'data listChapter');
        listChapter.value = [];
      } else {
        log('chapter ada', name: 'data listChapter');
        listChapter.value = resultChapters.data;
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
//
// Future getAllComment() async {
//   await commentProvider.fetchCommentByBookId(dataBook.uuid).then((v) {
//     v.data.map(
//       (e) => log(e.comment.toString(), name: 'data comment'),
//     );
//     if (v.data == []) {
//       log('comment kosong', name: 'data comment');
//       listComments.value = [];
//     } else {
//       log('comment ada', name: 'data comment');
//       listComments.value = v.data;
//     }
//   }).onError((e, st) {
//     listComments.value = [];
//   });
// }

// Future getAllLike() async {
//   await likeProvider.fetchLikeByBookId(uuidBook: dataBook.uuid).then((v) {
//     if (v.data == []) {
//       log('like kosong', name: 'data like');
//       listLike.value = [];
//     } else {
//       log('like ada', name: 'data like');
//       listLike.value = v.data;
//       final idUser = prefServices.getUserUuid;
//       final isLike = v.data.where((e) => e.user.uuid == idUser);
//       if (isLike.isEmpty) {
//         isLikeState.value = false;
//       } else {
//         isLikeState.value = true;
//       }
//     }
//   }).onError((e, st) {
//     listLike.value = [];
//   });
// }

// Future getAllRating() async {
//   await ratingProvider.fetchRatingByBookId(uuidBook: dataBook.uuid).then((v) {
//     if (v.data.ratings == []) {
//       log('comment kosong', name: 'data like');
//       averageRate.value = 0.0;
//     } else {
//       log('comment ada', name: 'data like');
//       averageRate.value = v.data.averageRate;
//     }
//   }).onError((e, st) {
//     listLike.value = [];
//   });
// }

// Future getAllChapter() async {
//   await chapterProvider.fetchChapter(dataBook.uuid).then((v) {
//     if (v.status == false) {
//       log('comment kosong', name: 'data listChapter');
//       listChapter.value = [];
//     } else {
//       log('comment ada', name: 'data listChapter');
//       listChapter.value = v.data;
//     }
//   }).onError((e, st) {
//     listLike.value = [];
//   });
// }

// Future getUserLogin() async {
//   await userProvider.fetchUserId().then((v) {
//     if (v.data != null && v.data!.isPremium == '1') {
//       log('kosong', name: 'data isPremium');
//       isPremium.value = true;
//     } else {
//       log('ada', name: 'data isPremium');
//       isPremium.value = false;
//     }
//   }).onError((e, st) {
//     isPremium.value = false;
//   });
// }
}

// Model data untuk DetailController (dengan tambahan isLiked)
class ModelDataDetail {
  final RxList<UserComment> comments;
  final RxList<UserLike> likes;
  final double averageRate;
  final RxList<DataChapter> chapters;
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
    RxList<UserComment>? comments,
    RxList<UserLike>? likes,
    double? averageRate,
    RxList<DataChapter>? chapters,
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
