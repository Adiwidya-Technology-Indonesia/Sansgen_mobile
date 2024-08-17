import 'package:get/get.dart';

import '../../../../provider/user.dart';
import '../controllers/profile_preferenci_controller.dart';

class ProfilePreferenciBinding extends Bindings {
  @override
  void dependencies() {
     Get.lazyPut<UserProvider>(
      () => UserProvider(),
    );
    Get.lazyPut<ProfilePreferenciController>(
      () => ProfilePreferenciController(userProvider: Get.find()),
    );
  }
}
