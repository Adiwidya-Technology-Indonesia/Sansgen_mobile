import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../model/books.dart';

class DetailController extends GetxController {
  late BookModel book;

  void tapViewBottomSheetChapter(List<int> listChapter) {
    Get.bottomSheet(
      Container(
        width: double.infinity,
        padding: const EdgeInsets.only(
          top: 16,
          left: 16,
          right: 16,
        ),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
          ),
        ),
        child: Column(
          children: listChapter
              .map(
                (e) => Container(
                  height: 35,
                  margin: const EdgeInsets.only(bottom: 16),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Row(
                    children: [
                      Text("Chapter $e"),
                      const Text("Lorem ipsum dolor sit amet"),
                    ],
                  ),
                ),
              )
              .toList(),
        ),
      ),
    );
  }

  @override
  void onInit() {
    book = Get.arguments;
    super.onInit();
  }
}
