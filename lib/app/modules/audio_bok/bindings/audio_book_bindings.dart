import 'package:get/get.dart';
import 'package:sansgen/app/modules/audio_bok/controllers/audio_book_controller.dart';

class AudioBookBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AudioBookController>(
      () => AudioBookController(),
    );
  }
}
