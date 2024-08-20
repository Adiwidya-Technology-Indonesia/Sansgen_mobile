import 'dart:developer';

import 'package:get/get.dart';
import 'package:sansgen/app/data/books.dart';
import 'package:sansgen/model/book/book.dart';
import 'package:sansgen/provider/chapter.dart';

import '../../../../model/chapter/data_chapter.dart';
import '../../../../services/audio.dart';

class AudioBookController extends GetxController
    with StateMixin<ModelDataAudioPage> {
  final ChapterProvider chapterProvider;

  AudioBookController({
    required this.chapterProvider,
  });

  final audioPlayer = AudioService();

  final Rx<bool> stateAudio = false.obs;

  @override
  void onInit() async {
    const fileUri =
        'https://teknodipani.com/storage/music-file/Y2meta.app%20-%20merindukanmu%20(cover)%20(128%20kbps).mp3';

    await audioPlayer.playUrl(fileUri);

    // audioPlayer.play();
    // audioPlayer.setVolume(100);

    await getIdChapter();
    super.onInit();
  }

  @override
  void onClose() {
    audioPlayer.dispose();
    super.onClose();
  }

  void onAudio() {
    log(stateAudio.value.toString(), name: "stateAudio.value");
    if (stateAudio.isFalse) {
      audioPlayer.play();
      audioPlayer.setVolume(100);
      stateAudio.value = !stateAudio.value;
    } else {
      audioPlayer.stop();
      audioPlayer.setVolume(0);
      stateAudio.value = !stateAudio.value;
    }
  }

  Future getIdChapter() async {
    chapterProvider
        .fetchIdChapter(
            idBook: '7093883d-88c6-4a3c-a6bd-8e3734897eba', idChapter: '1')
        .then((v) {
          log(v.data.toString(), name: 'Data Chapter');
      final dataPage = ModelDataAudioPage(dataBook: book, dataChapter: v.data);
      change(dataPage, status: RxStatus.success());
    }).onError((e, st) {
      change(null, status: RxStatus.error(e.toString()));
    });
  }
}

class ModelDataAudioPage {
  final DataBook dataBook;
  final DataChapter dataChapter;

  ModelDataAudioPage({required this.dataBook, required this.dataChapter});
}
