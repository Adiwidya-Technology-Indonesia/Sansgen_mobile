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
    ModelPreferenci(id: 1, title: 'Bisnis', isSelected: false.obs),
    ModelPreferenci(id: 2, title: 'Pengembangan diri', isSelected: false.obs),
    ModelPreferenci(id: 3, title: 'Marketing & Sales', isSelected: false.obs),
    ModelPreferenci(id: 4, title: 'Sains', isSelected: false.obs),
    ModelPreferenci(id: 5, title: 'Filsafat', isSelected: false.obs),
    ModelPreferenci(id: 6, title: 'Agama', isSelected: false.obs),
    ModelPreferenci(id: 7, title: 'Politik', isSelected: false.obs),
    ModelPreferenci(id: 8, title: 'Sejarah', isSelected: false.obs),
  ];
  void simpan() {
    try {
      final categorySelesai = listPreferences.where((e)=>e.isSelected.value == true).map((v)=>v.id).toList();
      final request = ModelRequestPatchUser(
          idCategory: categorySelesai
      );
      userProvider.patchReference(request).then((v) async {
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
