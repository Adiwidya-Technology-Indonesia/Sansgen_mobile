import 'package:get/get.dart';
import 'package:sansgen/app/modules/audio_bok/controllers/audio_book_controller.dart';
import 'package:sansgen/provider/book.dart';
import 'package:sansgen/provider/chapter.dart';

class AudioBookBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ChapterProvider>(
      () => ChapterProvider(),
    );
    Get.lazyPut<AudioBookController>(
      () => AudioBookController(
        chapterProvider: Get.find(),
      ),
    );
  }
}
