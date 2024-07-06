import 'package:get/get.dart';

import '../../../../../provider/auth.dart';
import '../../../../../services/prefs.dart';
import '../controllers/register_controller.dart';

class RegisterBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PrefService>(
      () => PrefService(),
    );
    Get.lazyPut<AuthProvider>(
      () => AuthProvider(),
    );
    Get.lazyPut<RegisterController>(
      () => RegisterController(
        authProvider: Get.find(),
        prefService: Get.find(),
      ),
    );
  }
}
