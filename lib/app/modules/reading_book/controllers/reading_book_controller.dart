import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:sansgen/model/book/book.dart';
import 'package:sansgen/model/focus/request_put.dart';
import 'package:sansgen/utils/ext_int.dart';

import '../../../../keys/api.dart';
import '../../../../keys/env.dart';
import '../../../../model/chapter/data_chapter.dart';
import '../../../../provider/chapter.dart';
import '../../../../provider/focus.dart';
import '../../../../services/audio.dart';

class ReadingBookController extends GetxController
    with StateMixin<ModelDataReadingPage> {
  final ChapterProvider chapterProvider;
  final FocusProvider focusProvider;

  ReadingBookController({
    required this.chapterProvider,
    required this.focusProvider,
  });

  final musicPlayer = AudioService();
  final stopwatchReading = Stopwatch();
  final stopwatchFocus = Stopwatch();

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

  // int initDuration = 10;

  // final CountDownController controllerTimer = CountDownController();
  final String baseURL = dotenv.get(KeysEnv.baseUrl);

  @override
  void onInit() async {
    log('init Reading', name: 'on init');
    stopwatchReading.start();
    getArgument();
    super.onInit();
  }

  @override
  void onClose() async {
    musicPlayer.dispose();
    await sendDataFocus();
    super.onClose();
  }

  Future sendDataFocus() async {
    stopwatchReading.stop();
    stopwatchFocus.stop();

    final readings = stopwatchReading.elapsedMilliseconds.toFormattedTime();

    final focus = stopwatchFocus.elapsedMilliseconds.toFormattedTime();

    final manyBooks = 1;

    log(readings, name: 'readings');
    log(focus, name: 'focus');
    log(manyBooks.toString(), name: 'manyBooks');

    final request = ModelRequestPutFocus(
      readings: readings,
      manyBooks: manyBooks,
      focus: focus,
    );

    focusProvider.putFocusCurrent(request).then((v) {
      Get.snackbar('info', 'Berhasil memperbarui habbit');
    }).onError((e, st) {
      Get.snackbar('info', 'Gagal memperbarui habbit');
    });
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
      stopwatchFocus.start();
    } else {
      musicPlayer.stop();
      musicPlayer.setVolume(0);
      stateMusic.value = !stateMusic.value;
      stopwatchFocus.stop();
      final focus = stopwatchFocus.elapsedMilliseconds.toFormattedTime();
      log(focus, name: 'focus');
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
    getChapter(currentChapter.value.toString());
    Get.back();
  }

  void setCurrentContent(String value) {
    currentContentChapter.value = value;
  }

  void previousChapter() {
    if (currentChapter.value == 1) {
      Get.snackbar('info', 'Chapter 1 is the first chapter');
    } else {
      currentChapter.value--;
      getChapter(currentChapter.value.toString());
    }
  }

  void nextChapter() {
    if (currentChapter.value == dataBook!.manyChapters) {
      Get.snackbar(
          'info', 'Chapter ${dataBook!.manyChapters} is the last chapter');
    } else {
      currentChapter.value++;
      getChapter(currentChapter.value.toString());
    }
  }

  void playAudioIfUrlsAvailable() async {
    urlStorage = baseURL + KeysApi.storage;
    if (urlStorage != null && urlMusic != null) {
      log(urlMusic!, name: 'url music isNotEmpty');
      musicPlayer.playerStream.listen((playerState) {
        if (playerState.processingState == ProcessingState.completed) {
          musicPlayer.jumToDuration(Duration.zero); // Kembali ke awal
          musicPlayer.play(); // Putar ulang
        }
      });
      musicPlayer.playUrl(urlMusic!); // Tidak perlu await di sini
    } else {
      log('kosong', name: 'url music isEmpty');
    }
  }

  Future getArgument() async {
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
      await getChapter(currentChapter.value.toString());
    } else {
      change(null, status: RxStatus.empty());
    }
  }

  Future getChapter(String idChapter) async {
    change(null, status: RxStatus.loading());
    chapterProvider
        .fetchIdChapter(
      idBook: dataBook!.uuid,
      idChapter: idChapter,
    )
        .then((v) {
      final formattedAudioUrl = "$baseURL${KeysApi.storage}/${dataBook!.music}";
      final dataPage = ModelDataReadingPage(
          dataBook: dataBook!.copyWith(music: formattedAudioUrl),
          dataChapter: v.data);
      urlMusic = dataPage.dataBook.music;
      log(urlMusic!, name: 'Data urlMusic');
      change(dataPage, status: RxStatus.success());
      if (urlMusic != null || urlMusic != '') {
        isViewMusic.value = true;
        playAudioIfUrlsAvailable(); // Coba putar music setelah urlMusic tersedia
      }
    }).onError((e, st) {
      change(null, status: RxStatus.error(e.toString()));
    });
  }
}

class ModelDataReadingPage {
  final DataBook dataBook;
  final DataChapter dataChapter;

  ModelDataReadingPage({required this.dataBook, required this.dataChapter});
}
