import 'dart:developer';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:sansgen/app/data/books.dart';
import 'package:sansgen/keys/api.dart';
import 'package:sansgen/model/book/book.dart';
import 'package:sansgen/provider/chapter.dart';

import '../../../../keys/env.dart';
import '../../../../model/chapter/data_chapter.dart';
import '../../../../services/audio.dart';

class AudioBookController extends GetxController
    with StateMixin<ModelDataAudioPage> {
  final ChapterProvider chapterProvider;

  AudioBookController({
    required this.chapterProvider,
  });

  final String baseURL = dotenv.get(KeysEnv.baseUrl);
  final audioPlayer = AudioService();
  String? urlStorage;
  String? urlAudio;

  final Rx<bool> stateAudio = false.obs;
  final Rx<bool> isViewListing = false.obs;

  void stateViewListing() => isViewListing.value = !isViewListing.value;

  @override
  void onInit() async {
    await getIdChapter();
    super.onInit();
  }

  @override
  void onClose() {
    audioPlayer.dispose();
    super.onClose();
  }

  void playAudioIfUrlsAvailable() {
    urlStorage = baseURL + KeysApi.storage;
    if (urlStorage != null && urlAudio != null) {
      log(urlAudio!, name: 'url audio isNotEmpty');
      audioPlayer.playUrl(urlAudio!); // Tidak perlu await di sini
    } else {
      log('kosong', name: 'url audio isEmpty');
    }
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
            idBook: '58170fdf-f77d-464f-a2e3-2eb6a4b069e4', idChapter: '1')
        .then((v) {
      final formattedAudioUrl = "$baseURL${KeysApi.storage}/${v.data.audio}";
      final dataPage = ModelDataAudioPage(
          dataBook: book,
          dataChapter: v.data.copyWith(audio: formattedAudioUrl));
      urlAudio = dataPage.dataChapter.audio;
      log(urlAudio!, name: 'Data urlAudio');
      change(dataPage, status: RxStatus.success());
      playAudioIfUrlsAvailable(); // Coba putar audio setelah urlAudio tersedia
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
