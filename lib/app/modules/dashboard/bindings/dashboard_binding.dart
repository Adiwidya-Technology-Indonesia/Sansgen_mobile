import 'package:get/get.dart';
import 'package:sansgen/app/modules/home/controllers/home_controller.dart';
import 'package:sansgen/app/modules/kategori/controllers/kategori_controller.dart';
import 'package:sansgen/app/modules/profil/controllers/profil_controller.dart';
import 'package:sansgen/app/modules/riwayat/controllers/riwayat_controller.dart';
import 'package:sansgen/provider/book.dart';
import 'package:sansgen/provider/book.dart';

import '../../../../provider/best_for_you.dart';
import '../controllers/dashboard_controller.dart';

class DashboardBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BookProvider>(
      () => BookProvider(),
    );
    Get.lazyPut<BestForYouProvider>(
      () => BestForYouProvider(),
    );
    Get.lazyPut<DashboardController>(
      () => DashboardController(),
    );
    Get.lazyPut<HomeController>(
      () => HomeController(
        bookProvider: Get.find(),
        bestForYouProvider: Get.find(),
      ),
    );
    Get.lazyPut<KategoriController>(
      () => KategoriController(
        bookProvider: Get.find(),
      ),
    );
    Get.lazyPut<RiwayatController>(
      () => RiwayatController(),
    );
    Get.lazyPut<ProfilController>(
      () => ProfilController(),
    );
  }
}
