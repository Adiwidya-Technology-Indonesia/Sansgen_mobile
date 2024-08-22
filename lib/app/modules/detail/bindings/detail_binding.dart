import 'package:get/get.dart';
import 'package:sansgen/provider/chapter.dart';
import 'package:sansgen/provider/history.dart';
import 'package:sansgen/provider/like.dart';
import 'package:sansgen/provider/rate.dart';
import 'package:sansgen/provider/user.dart';

import '../../../../provider/comment.dart';
import '../controllers/detail_controller.dart';

class DetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CommentProvider>(
      () => CommentProvider(),
    );
    Get.lazyPut<LikeProvider>(
      () => LikeProvider(),
    );
    Get.lazyPut<RatingProvider>(
      () => RatingProvider(),
    );
    Get.lazyPut<ChapterProvider>(
      () => ChapterProvider(),
    );
    Get.lazyPut<HistoryProvider>(
          () => HistoryProvider(),
    );
    Get.lazyPut<UserProvider>(
          () => UserProvider(),
    );
    Get.lazyPut<DetailController>(
      () => DetailController(
        commentProvider: Get.find(),
        likeProvider: Get.find(),
        ratingProvider: Get.find(),
        chapterProvider: Get.find(),
        userProvider: Get.find(),
      ),
    );
  }
}
