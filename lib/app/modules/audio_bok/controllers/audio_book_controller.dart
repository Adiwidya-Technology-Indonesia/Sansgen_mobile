import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:sansgen/app/data/books.dart';
import 'package:sansgen/keys/api.dart';
import 'package:sansgen/model/book/book.dart';
import 'package:sansgen/provider/chapter.dart';

import '../../../../keys/env.dart';
import '../../../../model/chapter/data_chapter.dart';
import '../../../../provider/user.dart';
import '../../../../services/audio.dart';
import '../../../../services/common.dart';

class AudioBookController extends GetxController
    with StateMixin<ModelDataAudioPage> {
  final ChapterProvider chapterProvider;
  final UserProvider userProvider;

  AudioBookController({
    required this.chapterProvider,
    required this.userProvider,
  });

  DataBook? dataBook;
  var listChapter = <DataChapter>[];

  final ScrollController scrollController = ScrollController();
  final scrollSpeed = 0.0.obs;
  final isPremium = false.obs;

  final String baseURL = dotenv.get(KeysEnv.baseUrl);
  final audioPlayer = AudioService();
  String? urlStorage;
  String? urlAudio;

  final Rx<bool> stateAudio = false.obs;
  final Rx<bool> isViewListing = false.obs;
  final isAutoScrolling = false.obs;

  final Rx<int> currentChapter = 0.obs;
  final Rx<String> currentIdChapter = ''.obs;
  final Rx<String> currentContentChapter = "".obs;

  PositionData? isPositionData;

  void stateViewListing() => isViewListing.value = !isViewListing.value;

  @override
  void onInit() async {
    getArgument();
    super.onInit();
  }

  @override
  void onClose() {
    audioPlayer.dispose();
    super.onClose();
  }

  void playAudioIfUrlsAvailable() async {
    urlStorage = baseURL + KeysApi.storage;
    if (urlStorage != null && urlAudio != null) {
      log(urlAudio!, name: 'url audio isNotEmpty');
      audioPlayer.playUrl(urlAudio!); // Tidak perlu await di sini
      isPositionData = await audioPlayer.positionalDataStream.first;
      log(isPositionData.toString(), name: "isPositionData");
      // Hitung scrollSpeed berdasarkan durasi audio
      final totalDuration = isPositionData?.duration ?? Duration.zero;
      final maxScrollExtent = scrollController.position.maxScrollExtent;
      log(maxScrollExtent.toString(), name: 'maxScrollExtent');
      scrollSpeed.value = maxScrollExtent / totalDuration.inSeconds;
      log(scrollSpeed.value.toString(), name: 'scrollSpeed');
    } else {
      log('kosong', name: 'url audio isEmpty');
    }
  }

  void startAutoScroll() {
    final maxScrollExtent = scrollController.position.maxScrollExtent;
    final duration = Duration(
        milliseconds: (maxScrollExtent / scrollSpeed.value * 1000).toInt());
    isAutoScrolling.value = true;
    scrollController.animateTo(
      maxScrollExtent,
      duration: duration,
      curve: Curves.linear,
    );
  }

  void stopAutoScroll() {
    isAutoScrolling.value = false;
    scrollController
        .jumpTo(scrollController.offset); // Menghentikan animasi scroll
  }

  void onAudio() {
    log(stateAudio.value.toString(), name: "stateAudio.value");
    if (stateAudio.isFalse) {
      audioPlayer.play();
      audioPlayer.setVolume(100);
      stateAudio.value = !stateAudio.value;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        startAutoScroll();
      });
    } else {
      audioPlayer.stop();
      audioPlayer.setVolume(0);
      stateAudio.value = !stateAudio.value;
      stopAutoScroll();
    }
  }

  void setCurrentChapter(String value) async {
    currentChapter.value = int.parse(value);
    await getChapter(currentChapter.value.toString());
    Get.back();
  }

  void setCurrentContent(String value) {
    currentContentChapter.value = value;
  }

  void setCurrentIdChapterByNumber(String value) {
    currentIdChapter.value = listChapter
        .where((e) => e.number == value)
        .map((v) => v.id.toString())
        .toList()
        .first;
  }

  void previousChapter() async {
    if (currentChapter.value == 1) {
      Get.snackbar('info', 'Chapter 1 is the first chapter');
    } else {
      currentChapter.value--;
      await getChapter(currentChapter.value.toString());
    }
  }

  void nextChapter() async {
    if (isPremium.value == false && currentChapter.value >= 3) {
      Get.snackbar(
        'info',
        'Anda belum bisa membuka chapter selanjutnya, karena akun anda belum premium',
      );
    } else if (currentChapter.value == dataBook!.manyChapters) {
      Get.snackbar(
          'info', 'Chapter ${dataBook!.manyChapters} is the last chapter');
    } else {
      currentChapter.value++;
      await getChapter(currentChapter.value.toString());
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
      // currentIdChapter.value = initDataChapter.id.toString();
      dataBook = initDataBook;
      currentContentChapter.value = initDataChapter.content;
      await getChapter(currentChapter.value.toString());
      await getUserLogin();
    } else {
      log("kosong", name: 'arguments');
    }
  }

  Future getChapter(
    String numberChapter,
  ) async {
    setCurrentIdChapterByNumber(numberChapter);
    chapterProvider
        .fetchIdChapter(
            idBook: dataBook!.uuid, idChapter: currentIdChapter.value)
        .then((v) {
      final formattedAudioUrl = "$baseURL${KeysApi.storage}/${v.data.audio}";
      final dataPage = ModelDataAudioPage(
          dataBook: book,
          dataChapter: v.data.copyWith(audio: formattedAudioUrl));
      urlAudio = dataPage.dataChapter.audio;
      setCurrentContent(dataPage.dataChapter.content);
      log(urlAudio!, name: 'Data urlAudio');
      change(dataPage, status: RxStatus.success());
      if (urlAudio != null || urlAudio != '') {
        playAudioIfUrlsAvailable(); // Coba putar music setelah urlAudio tersedia
      }
    }).onError((e, st) {
      change(null, status: RxStatus.error(e.toString()));
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
}

class ModelDataAudioPage {
  final DataBook dataBook;
  final DataChapter dataChapter;

  ModelDataAudioPage({required this.dataBook, required this.dataChapter});
}
