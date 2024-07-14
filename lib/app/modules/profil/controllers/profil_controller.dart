import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sansgen/utils/ext_context.dart';

import '../../../routes/app_pages.dart';

class ProfilController extends GetxController {
  void logOutButton(BuildContext context) {
    Get.defaultDialog(
        title: 'KELUAR',
        middleText: 'Apakah anda yakin untuk keluar?',
        confirm: TextButton(
            onPressed: () {Get.toNamed(Routes.LOGIN);},
            child: Text(
              'Keluar',
              style: context.titleMedium
                  .copyWith(color: context.colorScheme.surface),
            )),
        cancel: TextButton(
            onPressed: () => Get.back(), child:Text('Cancel', style: context.titleMedium
                  .copyWith(color: context.colorScheme.surface),)));
  }

  void paymentButton(BuildContext context){
    Get.defaultDialog(
      title: 'PREMIUM',
      middleText: 'Nikmati membaca buku tampa batas dan nikmati semua fitur yang ada dalam aplikasi dengan meng-upgrade akun anda menjadi premium hanya dengan membayar \$11.00',
       confirm: TextButton(
            onPressed: () {},
            child: Text(
              'Ya',
              style: context.titleMedium
                  .copyWith(color: context.colorScheme.surface),
            )),
        cancel: TextButton(
            onPressed: () => Get.back(), child:Text('Tidak', style: context.titleMedium
                  .copyWith(color: context.colorScheme.surface),)));
  }
}
