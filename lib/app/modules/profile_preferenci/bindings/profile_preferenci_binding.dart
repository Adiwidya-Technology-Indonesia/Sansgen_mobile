import 'package:get/get.dart';

import '../controllers/profile_preferenci_controller.dart';

class ProfilePreferenciBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProfilePreferenciController>(
      () => ProfilePreferenciController(),
    );
  }
}
