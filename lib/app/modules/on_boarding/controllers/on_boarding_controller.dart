import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:sansgen/model/user/request_patch_user.dart';
import 'package:sansgen/provider/user.dart';
import 'package:sansgen/services/prefs.dart';

import '../../../../keys/assets_images.dart';
import '../../../../model/error.dart';
import '../../../../model/on_boarding/gender.dart';
import '../../../../model/on_boarding/on_boarding.dart';
import '../../../../model/on_boarding/referency.dart';
import '../../../routes/app_pages.dart';
import '../views/age.dart';
import '../views/gender.dart';
import '../views/preferences.dart';

class OnBoardingController extends GetxController {
  final UserProvider userProvider;

  OnBoardingController({required this.userProvider});

  final PrefService prefService = PrefService();

  final PageController pageController = PageController();
  final Rx<int> currentPage = 0.obs;
  final Rx<int> selectedIndexGender = 0.obs;
  final Rx<int> selectedIndexAge = 0.obs;

  final listGender = <ModelGender>[
    ModelGender(title: 'Laki-Laki', imageAssets: KeysAssetsImages.maleGender),
    ModelGender(title: 'Perempuan', imageAssets: KeysAssetsImages.femaleGender),
  ];

  final listAge = ['18-24', '25-34', '35-44', '45-54', '55+'];

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

  final Rx<String> selectedGender = ''.obs;
  final Rx<String> selectedAge = ''.obs;

  String setGender(String value) {
    selectedGender.value = value;
    return selectedGender.value;
  }

  String setAge(String value) {
    selectedAge.value = value;
    return selectedAge.value;
  }

  void nextPage() {
    if (currentPage.value == 0 && selectedGender.isNotEmpty) {
      currentPage.value++;
    } else if (currentPage.value == 0 && selectedGender.isEmpty) {
      Get.snackbar(
        'Info',
        'Silakan pilih jenis kelamin terlebih dahulu',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.grey,
        colorText: Colors.white,
      );
    } else if (currentPage.value == 1 && selectedAge.isNotEmpty) {
      currentPage.value++;
    } else if (currentPage.value == 1 && selectedAge.isEmpty) {
      Get.snackbar(
        'Info',
        'Silakan pilih umur terlebih dahulu',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.grey,
        colorText: Colors.white,
      );
    } else if (currentPage.value == 2) {
      final selectedCount = listPreferences
          .where((element) => element.isSelected.value == true)
          .length;
      if (selectedCount >= 3) {
        simpan();
      } else {
        Get.snackbar(
          'Info',
          'Silakan pilih setidaknya 3 kategori buku',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.grey,
          colorText: Colors.white,
        );
      }
    }
  }

  void simpan() {
    try {
      EasyLoading.show(status: "loading");
      final listIdCategory = listPreferences
          .where((v) => v.isSelected.value == true)
          .map((e) => e.id)
          .toList();
      log(listIdCategory.toString(), name: "data list preferenci is selected");
      final request = ModelRequestPatchUser(
        gender: selectedGender.value,
        rangeAge: selectedAge.value,
        idCategory: listIdCategory,
      );
      log(request.toJson().toString(), name: "request patch user");

      userProvider.patchOnBoarding(request).then((response) async {
        if (response.statusCode == 200) {
          EasyLoading.showSuccess('Update Data berhasil');
          await prefService.putOnBoarding(true);
          Get.offAllNamed(Routes.DASHBOARD);
          return;
        } else if (response.statusCode == 422) {
          EasyLoading.showError(response.body['message']);
        } else if (response.statusCode == null) {
          EasyLoading.showError('No internet connection!');
        } else {
          EasyLoading.showError('Server Error');
        }
        EasyLoading.dismiss();
      }).onError((e, st) {
        EasyLoading.dismiss();
        final errors = Errors(message: ['$e', '$st']);
        final dataError = ModelResponseError(errors: errors);
        log(dataError.toJson().toString(), name: "onError");
        EasyLoading.showError('Update Data Gagal');
        return;
      });
    } catch (e) {
      Get.defaultDialog(
        title: 'Error',
        content: Text('Error: $e'),
      );
    }
    // tampilkanSemuaNilai();
  }

  void tampilkanSemuaNilai() {
    String gender = selectedGender.value;
    String age = selectedAge.value;
    List<String> preferences = listPreferences
        .where((element) => element.isSelected.value == true)
        .map((element) => element.title)
        .toList();

    log('Gender: $gender');
    log('Age: $age');
    log('Preferences: $preferences');
  }

  final listPage = <ModelOnBoarding>[
    ModelOnBoarding(
      title: 'Pilih jenis kelamin kamu',
      titleAppBar: 'Tentang Kamu',
      titleButton: 'Lanjut',
      page: const GenderView(),
    ),
    ModelOnBoarding(
      title: 'Pilih umur anda',
      titleAppBar: 'Tentang Kamu',
      titleButton: 'Lanjut',
      page: const AgeView(),
    ),
    ModelOnBoarding(
      title: 'Pilih kategori buku yang kamu sukai',
      titleAppBar: 'Referensi Kamu',
      titleButton: 'Simpan',
      page: const PreferenciView(),
    ),
  ];

  @override
  void onInit() async {
    await prefService.prefInit();
    currentPage.value = 0;
    super.onInit();
  }
}
