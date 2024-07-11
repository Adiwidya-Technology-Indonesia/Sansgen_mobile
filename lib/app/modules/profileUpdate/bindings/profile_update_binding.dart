import 'package:get/get.dart';
import 'package:sansgen/app/modules/profileUpdate/controllers/image_profil_controller.dart';

import '../controllers/profile_update_controller.dart';

class ProfileUpdateBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProfileUpdateController>(
      () => ProfileUpdateController(),
    );
    Get.lazyPut<ImageUpdateController>(
      () => ImageUpdateController(),
    );
  }
}
