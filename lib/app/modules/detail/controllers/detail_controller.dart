import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:sansgen/utils/ext_context.dart';

import '../../../../model/book/book.dart';
import '../../../routes/app_pages.dart';

class DetailController extends GetxController {
  late DataBook book;

  void tapViewBottomSheetChapter(List<int> listChapter, BuildContext context) {
    Get.bottomSheet(
      contentBottomSheet(context, listChapter, book),
    );
  }

  @override
  void onInit() {
    book = Get.arguments;
    super.onInit();
  }
}

Container contentBottomSheet(
    BuildContext context, List<int> listChapter, DataBook book) {
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
                  Get.toNamed(Routes.READING_BOOK, arguments: {
                    'book': book,
                    'chapter': e,
                  });
                },
              ),
            )
            .toList(),
      ],
    ),
  );
}

GestureDetector cardChapter({
  required BuildContext context,
  required int value,
  required Function() onTap,
}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      height: 35,
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 12),
            color: context.colorScheme.onPrimary.withOpacity(0.2),
            blurRadius: 12,
          ),
        ],
      ),
      child: Row(
        children: [
          Text("Chapter $value"),
          const Gap(12),
          const Text("Lorem ipsum dolor sit amet"),
        ],
      ),
    ),
  );
}
