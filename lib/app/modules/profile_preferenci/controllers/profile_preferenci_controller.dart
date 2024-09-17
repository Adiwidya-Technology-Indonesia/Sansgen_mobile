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

class ProfilePreferenciController extends GetxController
    with StateMixin<ModelUser> {
  final UserProvider userProvider;

  ProfilePreferenciController({required this.userProvider});

  ModelUser? dataUser;

  final listPreferences = <ModelPreferenci>[
    ModelPreferenci(id: 1, title: 'Bisnis', isSelected: false.obs),
    ModelPreferenci(id: 2, title: 'Pengembangan Diri', isSelected: false.obs),
    ModelPreferenci(id: 3, title: 'Marketing & Sales', isSelected: false.obs),
    ModelPreferenci(id: 4, title: 'Sains', isSelected: false.obs),
    ModelPreferenci(id: 5, title: 'Filsafat', isSelected: false.obs),
    ModelPreferenci(id: 6, title: 'Agama', isSelected: false.obs),
    ModelPreferenci(id: 7, title: 'Politik', isSelected: false.obs),
    ModelPreferenci(id: 8, title: 'Sejarah', isSelected: false.obs),
  ];

  @override
  void onInit() async {
    getArgument();
    super.onInit();
  }

  Future getArgument() async {
    try {
      if (Get.arguments != null) {
        dataUser = Get.arguments;
        for (var pref in listPreferences) {
          if (dataUser!.categories
              .map((e) => e.toLowerCase())
              .contains(pref.title.toLowerCase())) {
            pref.isSelected.value = true;
          }
        }
        change(dataUser, status: RxStatus.success());
      } else {
        dataUser = null;
        change(dataUser, status: RxStatus.empty());
      }
    } catch (e) {
      change(null, status: RxStatus.error(e.toString()));
    }
  }

  Future simpan() async {
    try {
      final categorySelesai = listPreferences
          .where((e) => e.isSelected.value == true)
          .map((v) => v.id)
          .toList();
      if (categorySelesai.length < 3) {
        Get.snackbar(
          'Info',
          'Silakan pilih setidaknya 3 kategori buku',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.grey,
          colorText: Colors.white,
        );
        return;
      } else {
        EasyLoading.show(status: "Loading");

        final request = ModelRequestPatchUser(idCategory: categorySelesai);

        return userProvider.patchReference(request).then((v) async {
          EasyLoading.dismiss();
          EasyLoading.showSuccess('Update Data berhasil');
          log(v.toJson().toString());
          Get.offAllNamed(Routes.DASHBOARD, arguments: 3);
          return;
        }).onError((e, st) {
          EasyLoading.dismiss();
          final errors = Errors(message: ['$e', '$st']);
          final dataError = ModelResponseError(errors: errors);
          log(dataError.toJson().toString());
          EasyLoading.showError('Update Data Gagal');
          return;
        });
      }
    } catch (e) {
      Get.defaultDialog(
        title: 'Error',
        content: Text('Error: $e'),
      );
    }
  }
}
