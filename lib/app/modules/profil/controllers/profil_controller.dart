import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sansgen/utils/ext_context.dart';
import '../../../../model/user/user.dart';
import '../../../../provider/user.dart';
import '../../../routes/app_pages.dart';

class ProfilController extends GetxController with StateMixin<ModelUser> {
  final UserProvider userProvider;

  ProfilController({required this.userProvider});

  void logOutButton(BuildContext context) {
    Get.defaultDialog(
        title: 'KELUAR',
        middleText: 'Apakah anda yakin untuk keluar?',
        confirm: TextButton(
            onPressed: () {
              Get.toNamed(Routes.LOGIN);
            },
            child: Text(
              'Keluar',
              style: context.titleMedium
                  .copyWith(color: context.colorScheme.surface),
            )),
        cancel: TextButton(
            onPressed: () => Get.back(),
            child: Text(
              'Cancel',
              style: context.titleMedium
                  .copyWith(color: context.colorScheme.surface),
            )));
  }

  @override
  void onInit() async {
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
      change(null, status: RxStatus.error(e.toString()));
    });
  }
  
}
