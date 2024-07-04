import 'package:get/get.dart';
import 'package:sansgen/app/modules/home/controllers/home_controller.dart';
import 'package:sansgen/app/modules/kategori/controllers/kategori_controller.dart';
import 'package:sansgen/app/modules/profil/controllers/profil_controller.dart';
import 'package:sansgen/app/modules/riwayat/controllers/riwayat_controller.dart';

import '../controllers/dashboard_controller.dart';

class DashboardBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DashboardController>(
      () => DashboardController(),
    );
    Get.lazyPut<HomeController>(
      () => HomeController(),
    );
    Get.lazyPut<KategoriController>(
      () => KategoriController(),
    );
    Get.lazyPut<RiwayatController>(
      () => RiwayatController(),
    );
    Get.lazyPut<ProfilController>(
      () => ProfilController(),
    );
  }
}
