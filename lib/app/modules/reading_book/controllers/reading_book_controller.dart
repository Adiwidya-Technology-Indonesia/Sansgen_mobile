import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sansgen/model/book/book.dart';

class ReadingBookController extends GetxController {
  final ScrollController scrollController = ScrollController();
  var scaffoldKey = GlobalKey<ScaffoldState>();
  var book = Get.arguments['book'] as DataBook;
  var chapter = Get.arguments['chapter'] as int;
  final Rx<int> currentChapter = 0.obs;
  final Rx<bool> stateMusic = false.obs;

  int initDuration = 10;

  final CountDownController controllerTimer = CountDownController();

  void openTimer(Widget widget) {
    Get.defaultDialog(
      title: "",
      content: widget,
    );
  }

  void onMusic()=> stateMusic.value = !stateMusic.value;

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

  void setCurrentChapter(int chapter) {
    currentChapter.value = chapter;
    Get.back();
  }

  void previousChapter() {
    if (chapter == 1) {
      Get.snackbar('info', 'Chapter 1 is the first chapter');
    } else {
      chapter--;
    }
  }

  void nextChapter() {
    if (chapter == [1, 2, 3, 4, 5, 6, 7, 8, 9, 10].length) {
      Get.snackbar(
          'info', 'Chapter ${[1, 2, 3, 4, 5, 6, 7, 8, 9, 10].length} is the last chapter');
    } else {
      chapter++;
    }
  }

  @override
  void onInit() {
    currentChapter.value = chapter;
    super.onInit();
  }
}
