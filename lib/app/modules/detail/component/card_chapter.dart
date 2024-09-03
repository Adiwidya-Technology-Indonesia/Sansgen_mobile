import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:sansgen/keys/assets_icons.dart';
import 'package:sansgen/utils/ext_context.dart';

import '../../../../model/chapter/data_chapter.dart';

GestureDetector cardChapter({
  required BuildContext context,
  required DataChapter value,
  required Function() onToReading,
  required Function() onToAudio,
  required bool isRead,
}) {
  return GestureDetector(
    onTap: onToReading,
    child: Container(
      height: 35,
      margin: const EdgeInsets.only(bottom: 8),
      // decoration: BoxDecoration(
      //   color: Colors.white,
      //   boxShadow: [
      //     // BoxShadow(
      //     //   offset: const Offset(0, 12),
      //     //   color: context.colorScheme.onPrimary.withOpacity(0.2),
      //     //   blurRadius: 12,
      //     // ),
      //   ],
      // ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              if (isRead) // Tampilkan ikon jika chapter telah dibaca
                Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: Icon(Icons.check, color: context.colorScheme.surface),
                ),
              Text("Bab ${value.number}", style: context.titleMediumBold),
              const Gap(12),
              SizedBox(
                width: Get.width * 0.6,
                child: Text(
                  value.title,
                  style: context.labelLarge.copyWith(
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ],
          ),
          if (value.audio != null)
            GestureDetector(
              onTap: onToAudio,
              child: SvgPicture.asset(KeysAssetsIcons.audio),
            ),
        ],
      ),
    ),
  );
}
