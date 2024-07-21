import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/payment_buy_controller.dart';

class PaymentBuyView extends GetView<PaymentBuyController> {
  const PaymentBuyView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PaymentBuyView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'PaymentBuyView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
