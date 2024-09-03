import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sansgen/utils/ext_context.dart';

import '../../../../model/chapter/data_chapter.dart';
import '../../../routes/app_pages.dart';
import '../../../../model/book/book.dart';
import 'card_chapter.dart';

Container contentBottomSheetChapter({
  required BuildContext context,
  required List<DataChapter> listChapter,
  required bool isPremium,
  required DataBook dataBook,
  required List<int>  readChapterIds,
}) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.only(
      top: 16,
      left: 16,
      right: 16,
    ),
    decoration: BoxDecoration(
      color: context.colorScheme.primary,
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(10),
        topRight: Radius.circular(10),
      ),
    ),
    child: ListView(
      children: [
        Text(
          "Total: ${listChapter.length} Bab",
          style: context.titleMedium,
        ),
        const Divider(),
        ...listChapter
            .map(
              (e) => cardChapter(
                context: context,
                value: e,
                isRead: readChapterIds.contains(e.id),
                onToReading: () {
                  final numberChapter = int.parse(e.number);
                  log(int.parse(e.number).toString(), name: 'number');
                  if (isPremium == false && numberChapter > 3) {
                    return Get.snackbar(
                      'info',
                      'Anda belum bisa membuka chapter ini, karena akun anda belum premium',
                    );
                  }
                  Get.toNamed(Routes.READING_BOOK, arguments: {
                    'book': dataBook,
                    'chapter': e,
                    'listChapter': listChapter,
                  });
                },
                onToAudio: () {
                  final numberChapter = int.parse(e.number);

                  if (isPremium == false && numberChapter > 3) {
                    return Get.snackbar(
                      'info',
                      'Anda belum bisa membuka chapter ini, karena akun anda belum premium',
                    );
                  }
                  Get.toNamed(Routes.AUDIO_BOOK, arguments: {
                    'book': dataBook,
                    'chapter': e,
                    'listChapter': listChapter,
                  });
                },
              ),
            )
            .toList(),
      ],
    ),
  );
}
