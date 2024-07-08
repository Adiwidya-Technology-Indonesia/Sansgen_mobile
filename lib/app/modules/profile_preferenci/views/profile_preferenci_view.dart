import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/profile_preferenci_controller.dart';

class ProfilePreferenciView extends GetView<ProfilePreferenciController> {
  const ProfilePreferenciView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ProfilePreferenciView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'ProfilePreferenciView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
