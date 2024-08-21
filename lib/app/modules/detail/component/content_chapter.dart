import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sansgen/utils/ext_context.dart';

import '../../../../model/chapter/data_chapter.dart';
import '../../../routes/app_pages.dart';
import '../../../../model/book/book.dart';
import 'card_chapter.dart';

Container contentBottomSheetChapter(
  BuildContext context,
  List<DataChapter> listChapter,
  DataBook dataBook,
) {
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
                onTap: () {
                  log(int.parse(e.number).toString(), name: 'number');
                  Get.toNamed(Routes.READING_BOOK, arguments: {
                    'book': dataBook,
                    'chapter': e,
                    'listChapter' : listChapter,
                  });
                },
              ),
            )
            .toList(),
      ],
    ),
  );
}
