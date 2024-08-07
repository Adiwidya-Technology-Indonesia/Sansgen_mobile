
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:sansgen/utils/ext_context.dart';

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