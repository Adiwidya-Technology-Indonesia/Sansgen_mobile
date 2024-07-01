import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/on_boarding_controller.dart';

class GenderView extends GetView<OnBoardingController> {
  const GenderView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('GenderView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'GenderView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
