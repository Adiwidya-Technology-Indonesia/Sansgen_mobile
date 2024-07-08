import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../widgets/card_book.dart';
import '../controllers/riwayat_controller.dart';

class BelumSelesaiDiBaca extends GetView<RiwayatController> {
  const BelumSelesaiDiBaca({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: controller.bookList.length,
      itemBuilder: (context, index) {
        final book = controller.bookList[index];
        return cardBook(
          book: book,
          context: context,
          onTap: () {
            controller.toDetails(book);
          },
        );
      },
    );
  }
}
