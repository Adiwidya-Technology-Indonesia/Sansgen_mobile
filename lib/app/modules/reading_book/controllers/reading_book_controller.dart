import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sansgen/model/books.dart';

class ReadingBookController extends GetxController {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  var book = Get.arguments['book'] as BookModel;
  var chapter = Get.arguments['chapter'] as int;
  final Rx<int> currentChapter = 0.obs;

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
    if (chapter == book.listChapter.length) {
      Get.snackbar(
          'info', 'Chapter ${book.listChapter.length} is the last chapter');
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
