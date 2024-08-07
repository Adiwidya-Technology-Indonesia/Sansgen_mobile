import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sansgen/utils/ext_context.dart';

import '../controllers/detail_controller.dart';
import 'input_comment.dart';

Container contentBottomSheetComment(
  BuildContext context,
  List<ModelComment> listComment,
  ScrollController scrollController,
) {
  String getDateTime(DateTime dateTime) {
    final dateTimeNow = DateTime.now();
    final listNameMonth = [
      "Jan",
      "Feb",
      "Mar",
      "Apr",
      "May",
      "Jun",
      "Jul",
      "Aug",
      "Sep",
      "Oct",
      "Nov",
      "Des"
    ];

    if (dateTime.year < dateTimeNow.year) {
      final namaMonth = listNameMonth[dateTime.month - 1];
      // Aug 2, 2022
      return "$namaMonth ${dateTime.day},${dateTime.year}";
    } else if (dateTime.month < dateTimeNow.month) {
      // 2 months ago
      return "${dateTimeNow.month - dateTime.month} bulan lalu";
    } else if (dateTime.day < dateTimeNow.day) {
      // 2 days lalu
      return "${dateTimeNow.day - dateTime.day} hari lalu";
    } else if (dateTime.hour < dateTimeNow.hour) {
      // 2 hours lalu
      return "${dateTimeNow.hour - dateTime.hour} jam lalu";
    } else if (dateTime.minute < dateTimeNow.minute) {
      return "${dateTimeNow.minute - dateTime.minute} menit lalu";
    }
    return "sekarang";
  }

  return Container(
    width: double.infinity,
    height: Get.height * 0.8,
    padding: const EdgeInsets.only(
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
    child: Column(
      children: [
        Text(
          "${listComment.length} Komentar",
          style: context.titleMedium,
        ),
        const Divider(),
        Expanded(
          child: ListView(
            controller: scrollController,
            reverse: true,
            children: listComment.reversed
                .map((e) => ListTile(
                      title: RichText(
                        text: TextSpan(
                          children: <TextSpan>[
                            TextSpan(
                                text: e.user, style: context.titleMediumBold),
                            TextSpan(
                                text: '  ${e.comment}',
                                style: context.labelLarge),
                          ],
                        ),
                      ),
                      subtitle: Text(getDateTime(e.time)),
                    ))
                .toList(),
          ),
        ),
        inputComment(
          hint: 'Tulis komentar anda',
          context: context,
        ),
      ],
    ),
  );
}
