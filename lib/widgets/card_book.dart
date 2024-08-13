import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:sansgen/model/book/book.dart';
import 'package:sansgen/utils/ext_context.dart';

import 'image_book.dart';

GestureDetector cardBook({
  required DataBook book,
  required BuildContext context,
  required Function() onTap,
}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      width: double.infinity,
      height: 160,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      decoration: BoxDecoration(
        // color: context.colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          imageBook(
            image: book.image,
            height: 160,
            width: 130,
            radius: 8,
          ),
          const Gap(12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                Text(book.title, style: context.titleSmallBold),
                const Gap(4),
                Text('By: ${book.publisher}', style: context.labelSmall),
                const Gap(4),
                Container(
                  height: 20,
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: context.colorScheme.onPrimary,
                    borderRadius: BorderRadius.circular(0),
                  ),
                  child: Text(
                    book.category,
                    style: context.labelSmall.copyWith(
                      color: context.colorScheme.primary,
                      height: 1,
                    ),
                  ),
                ),
                const Gap(4),
                Text(
                  '${book.manyChapters} bab',
                  style: context.labelSmall.copyWith(
                    color: context.colorScheme.secondary,
                  ),
                ),
                const Gap(12),
                Text('Sinopsis :', style: context.labelSmallBold),
                Text(
                  book.synopsis,
                  style: context.labelSmall.copyWith(
                    color: context.colorScheme.secondary,
                    inherit: true,
                    overflow: TextOverflow.ellipsis,
                  ),
                  softWrap: true,
                  maxLines: 3,
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
