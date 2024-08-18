import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:sansgen/services/prefs.dart';
import 'package:sansgen/utils/ext_context.dart';
import '../../../../model/user/user.dart';
import '../../../../provider/user.dart';
import '../../../routes/app_pages.dart';

class ProfilController extends GetxController with StateMixin<ModelUser> {
  final UserProvider userProvider;
  ProfilController({required this.userProvider});

  final PrefService prefService = PrefService();

  void logOutButton(BuildContext context) {
    Get.defaultDialog(
      title: 'KELUAR',
      middleText: 'Apakah anda yakin untuk keluar?',
      confirm: TextButton(
        onPressed: logOut,
        child: Text(
          'Keluar',
          style:
              context.titleMedium.copyWith(color: context.colorScheme.surface),
        ),
      ),
      cancel: TextButton(
        onPressed: () => Get.back(),
        child: Text(
          'Cancel',
          style:
              context.titleMedium.copyWith(color: context.colorScheme.surface),
        ),
      ),
    );
  }

  @override
  void onInit() async {
    await prefService.prefInit();
    await fetchDataProfil();
    super.onInit();
  }

  Future<void> fetchDataProfil() async {
    await userProvider.fetchUserId().then((v) async {
      if (v.data == null) {
        change(null, status: RxStatus.empty());
      } else {
        change(v.data, status: RxStatus.success());
      }
    }).onError((e, st) {
      logOut();
      change(null, status: RxStatus.error(e.toString()));
    });
  }

  Future logOut() async {
    final token = await prefService.getUserToken;
    if(token == null){
      await prefService.clearAllData();
      Get.offAllNamed(Routes.LOGIN);
    }
    EasyLoading.show(status: "Loading");
    userProvider.logOut().then((v) async {
      EasyLoading.dismiss();
      EasyLoading.showSuccess('Update Data berhasil');
      await prefService.clearAllData();
      Get.offAllNamed(Routes.LOGIN);
    }).onError((e, st) {
      EasyLoading.dismiss();
      EasyLoading.showError('Anda gagal log-out');
    });
  }
}
