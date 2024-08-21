import 'package:get/get.dart';

import '../../../../provider/chapter.dart';
import '../controllers/reading_book_controller.dart';

class ReadingBookBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ChapterProvider>(
      () => ChapterProvider(),
    );
    Get.lazyPut<ReadingBookController>(
      () => ReadingBookController(
        chapterProvider: Get.find(),
      ),
    );
  }
}
