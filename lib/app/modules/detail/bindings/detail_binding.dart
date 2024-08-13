import 'package:get/get.dart';

import '../../../../provider/comment.dart';
import '../controllers/detail_controller.dart';

class DetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CommentProvider>(
      () => CommentProvider(),
    );
    Get.lazyPut<DetailController>(
      () => DetailController(
        commentProvider: Get.find(),
      ),
    );
  }
}
