import 'dart:developer';

import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sansgen/model/book/book.dart';
import 'package:sansgen/services/audio.dart';

import '../../../../model/chapter/response_get.dart';

class ReadingBookController extends GetxController {
  final audioPlayer = AudioService();

  final ScrollController scrollController = ScrollController();
  var scaffoldKey = GlobalKey<ScaffoldState>();
  var book = Get.arguments['book'] as DataBook;
  var chapter = Get.arguments['chapter'] as int;
  var listChapter = Get.arguments['listChapter'] as List<DataChapter>;

  final Rx<int> currentChapter = 0.obs;
  final Rx<String> currentContentChapter = "".obs;
  final Rx<bool> stateMusic = false.obs;

  int initDuration = 10;

  final CountDownController controllerTimer = CountDownController();

  @override
  void onInit() async {
    await audioPlayer.playAssets('assets/music/tess.mp3');
    currentChapter.value = chapter;
    currentContentChapter.value =
        listChapter.where((v) => v.number == chapter.toString()).first.content;
    super.onInit();
  }

  @override
  void onClose() {
    audioPlayer.dispose();
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
      audioPlayer.play();
      audioPlayer.setVolume(5);
      stateMusic.value = !stateMusic.value;
    } else {
      audioPlayer.stop();
      audioPlayer.setVolume(0);
      stateMusic.value = !stateMusic.value;
    }
  }

  void onStartTimer() => controllerTimer.start();

  void onPauseTimer() => controllerTimer.pause();

  void onResumeTimer() => controllerTimer.resume();

  void onRestartTimer(int duration) =>
      controllerTimer.restart(duration: duration);

  void openDrawer() {
    scaffoldKey.currentState?.openDrawer();
  }

  void closeDrawer() {
    scaffoldKey.currentState?.openEndDrawer();
  }

  void setCurrentChapter(String value) {
    currentChapter.value = int.parse(value);
    setCurrentContent(int.parse(value));
    Get.back();
  }

  void setCurrentContent(int value) {
    currentContentChapter.value =
        listChapter.where((v) => v.number == value.toString()).first.content;
  }

  void previousChapter() {
    if (currentChapter.value == 1) {
      Get.snackbar('info', 'Chapter 1 is the first chapter');
    } else {
      currentChapter.value--;
      setCurrentContent(currentChapter.value);
    }
  }

  void nextChapter() {
    if (currentChapter.value == listChapter.length) {
      Get.snackbar('info', 'Chapter ${listChapter.length} is the last chapter');
    } else {
      currentChapter.value++;
      setCurrentContent(currentChapter.value);
    }
  }
}
