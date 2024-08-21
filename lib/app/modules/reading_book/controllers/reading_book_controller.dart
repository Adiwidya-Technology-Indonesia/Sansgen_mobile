import 'dart:developer';

import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:sansgen/model/book/book.dart';

import '../../../../keys/api.dart';
import '../../../../keys/env.dart';
import '../../../../model/chapter/data_chapter.dart';
import '../../../../provider/chapter.dart';
import '../../../../services/audio.dart';

class ReadingBookController extends GetxController {
  final ChapterProvider chapterProvider;

  ReadingBookController({
    required this.chapterProvider,
  });

  final musicPlayer = AudioService();

  final ScrollController scrollController = ScrollController();
  var scaffoldKey = GlobalKey<ScaffoldState>();

  DataBook? dataBook;
  List listChapter = <DataChapter>[];

  final Rx<int> currentChapter = 0.obs;
  final Rx<String> currentContentChapter = "".obs;
  final Rx<bool> stateMusic = false.obs;
  final Rx<bool> isViewMusic = false.obs;
  String? urlStorage;
  String? urlMusic;

  int initDuration = 10;

  // final CountDownController controllerTimer = CountDownController();
  final String baseURL = dotenv.get(KeysEnv.baseUrl);

  @override
  void onInit() async {
    log('init Reading', name: 'on init');
    getIdChapter();
    super.onInit();
  }

  @override
  void onClose() {
    musicPlayer.dispose();
    super.onClose();
  }

  void openTimer(Widget widget) {
    Get.defaultDialog(
      title: "",
      content: widget,
    );
  }

  void onMusic() {
    log(stateMusic.value.toString(), name: "stateMusic.value");
    if (stateMusic.isFalse) {
      musicPlayer.play();
      musicPlayer.setVolume(100);
      stateMusic.value = !stateMusic.value;
    } else {
      musicPlayer.stop();
      musicPlayer.setVolume(0);
      stateMusic.value = !stateMusic.value;
    }
  }

  // void onStartTimer() => controllerTimer.start();
  //
  // void onPauseTimer() => controllerTimer.pause();
  //
  // void onResumeTimer() => controllerTimer.resume();
  //
  // void onRestartTimer(int duration) =>
  //     controllerTimer.restart(duration: duration);

  void openDrawer() {
    scaffoldKey.currentState?.openDrawer();
  }

  void closeDrawer() {
    scaffoldKey.currentState?.openEndDrawer();
  }

  void setCurrentChapter(String value) {
    currentChapter.value = int.parse(value);
    // setCurrentContent(int.parse(value));
    Get.back();
  }

  // void setCurrentContent(int value) {
  //   currentContentChapter.value =
  //       listChapter.where((v) => v.number == value.toString()).first.content;
  // }

  void previousChapter() {
    if (currentChapter.value == 1) {
      Get.snackbar('info', 'Chapter 1 is the first chapter');
    } else {
      currentChapter.value--;
      // setCurrentContent(currentChapter.value);
    }
  }

  void nextChapter() {
    if (currentChapter.value == dataBook!.manyChapters) {
      Get.snackbar(
          'info', 'Chapter ${dataBook!.manyChapters} is the last chapter');
    } else {
      currentChapter.value++;
      // setCurrentContent(currentChapter.value);
    }
  }

  void playAudioIfUrlsAvailable() async {
    urlStorage = baseURL + KeysApi.storage;
    if (urlStorage != null && urlMusic != null) {
      log(urlMusic!, name: 'url music isNotEmpty');
      musicPlayer.playUrl(urlMusic!); // Tidak perlu await di sini
    } else {
      log('kosong', name: 'url music isEmpty');
    }
  }

  Future getIdChapter() async {
    if (Get.arguments != null) {
      final initDataBook = Get.arguments['book'] as DataBook;
      final initDataChapter = Get.arguments['chapter'] as DataChapter;
      listChapter = Get.arguments['listChapter'] as List<DataChapter>;

      log(initDataBook.toJson().toString(), name: "initDataBook");
      log(initDataChapter.toJson().toString(), name: "initDataChapter");
      log(listChapter.toString(), name: "listChapter");

      currentChapter.value = int.parse(initDataChapter.number);
      dataBook = initDataBook;
      currentContentChapter.value = initDataChapter.content;
      chapterProvider
          .fetchIdChapter(
        idBook: dataBook!.uuid,
        idChapter: initDataChapter.id.toString(),
      )
          .then((v) {
        final formattedAudioUrl =
            "$baseURL${KeysApi.storage}/${dataBook!.music}";
        final dataPage = ModelDataReadingPage(
            dataBook: dataBook!.copyWith(music: formattedAudioUrl),
            dataChapter: v.data);
        urlMusic = dataPage.dataBook.music;
        log(urlMusic!, name: 'Data urlMusic');
        // change(dataPage, status: RxStatus.success());
        if (urlMusic!.isURL) {
          isViewMusic.value = true;
          playAudioIfUrlsAvailable(); // Coba putar music setelah urlMusic tersedia
        }
      }).onError((e, st) {
        // change(null, status: RxStatus.error(e.toString()));
      });
    }
  }
}

class ModelDataReadingPage {
  final DataBook dataBook;
  final DataChapter dataChapter;

  ModelDataReadingPage({required this.dataBook, required this.dataChapter});
}
