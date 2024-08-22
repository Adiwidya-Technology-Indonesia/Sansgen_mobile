import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:sansgen/keys/assets_icons.dart';
import 'package:sansgen/utils/ext_context.dart';

import '../../../../model/chapter/data_chapter.dart';

GestureDetector cardChapter({
  required BuildContext context,
  required DataChapter value,
  required Function() onToReading,
  required Function() onToAudio,
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
              Text(
                "Bab ${value.number}",
                style: context.titleMediumBold,
              ),
              const Gap(12),
              Text(value.title),
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
