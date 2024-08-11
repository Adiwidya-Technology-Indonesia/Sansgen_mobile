import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sansgen/utils/ext_context.dart';

import '../../../../services/date_time.dart';
import '../controllers/detail_controller.dart';
import 'input_comment.dart';

Container contentBottomSheetComment(
  BuildContext context,
  List<ModelComment> listComment,
  ScrollController scrollController,
) {
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
                      subtitle: Text(DateTimeServices.getDateTime(e.time)),
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
