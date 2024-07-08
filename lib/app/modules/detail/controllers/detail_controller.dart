import 'package:get/get.dart';

import '../../../../model/books.dart';

class DetailController extends GetxController {
  late BookModel book;

  @override
  void onInit() {
    book = Get.arguments;
    super.onInit();
  }
}
