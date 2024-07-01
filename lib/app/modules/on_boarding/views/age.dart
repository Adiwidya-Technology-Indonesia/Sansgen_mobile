import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/on_boarding_controller.dart';

class AgeView extends GetView<OnBoardingController> {
  const AgeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AgeView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'AgeView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
