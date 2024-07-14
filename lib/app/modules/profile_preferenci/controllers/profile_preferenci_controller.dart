import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import 'package:sansgen/model/user/request_patch_user.dart';
import 'package:sansgen/model/user/user.dart';

import '../../../../model/error.dart';
import '../../../../model/on_boarding/referency.dart';
import '../../../../provider/user.dart';
import '../../../routes/app_pages.dart';

class ProfilePreferenciController extends GetxController with StateMixin<ModelUser>{
  final UserProvider userProvider;
  ProfilePreferenciController({required this.userProvider});
  final listPreferences = <ModelPreferenci>[
    ModelPreferenci(title: 'Bisnis', isSelected: false.obs),
    ModelPreferenci(title: 'Pengembangan diri', isSelected: false.obs),
    ModelPreferenci(title: 'Marketing & Sales', isSelected: false.obs),
    ModelPreferenci(title: 'Sains', isSelected: false.obs),
    ModelPreferenci(title: 'Filsafat', isSelected: false.obs),
    ModelPreferenci(title: 'Agama', isSelected: false.obs),
    ModelPreferenci(title: 'Politik', isSelected: false.obs),
    ModelPreferenci(title: 'Sejarah', isSelected: false.obs),
  ];
  void simpan() {
    try {
      // final categorySelesai = listPreferences.where((e)=>e.isSelected.value == true).toList().map((v)=>v.title);
      final request = ModelRequestPatchUser(
        category: listPreferences.first.title
      );
      userProvider.patchUserCurrent(request).then((v) async {
        EasyLoading.dismiss();
        EasyLoading.showSuccess('Update Data berhasil');
        log(v.toJson().toString());
        Get.offAllNamed(Routes.PROFIL);
        return;
      }).onError((e, st) {
        EasyLoading.dismiss();
        final errors = Errors(message: ['$e', '$st']);
        final dataError = ModelResponseError(errors: errors);
        log(dataError.toJson().toString());
        EasyLoading.showError('Update Data Gagal');
        return;
      });
    } catch (e) {
      Get.defaultDialog(
        title: 'Error',
        content: Text('Error: $e'),
      );
    }
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
