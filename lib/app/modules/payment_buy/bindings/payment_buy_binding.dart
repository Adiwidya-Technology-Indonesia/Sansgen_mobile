import 'package:get/get.dart';

import '../controllers/payment_buy_controller.dart';

class PaymentBuyBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PaymentBuyController>(
      () => PaymentBuyController(),
    );
  }
}
