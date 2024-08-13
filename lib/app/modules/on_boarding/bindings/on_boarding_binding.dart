import 'package:get/get.dart';
import 'package:sansgen/provider/user.dart';

import '../controllers/on_boarding_controller.dart';

class OnBoardingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UserProvider>(
      () => UserProvider(),
    );
    Get.lazyPut<OnBoardingController>(
      () => OnBoardingController(
        userProvider: Get.find(),
      ),
    );
  }
}
