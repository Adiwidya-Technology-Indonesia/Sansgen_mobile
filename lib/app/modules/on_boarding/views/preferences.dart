import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/on_boarding_controller.dart';

class PreferencesView extends GetView<OnBoardingController> {
  const PreferencesView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PreferencesView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'PreferencesView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
