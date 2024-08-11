import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../keys/assets_images.dart';
import '../../../../model/on_boarding/gender.dart';
import '../../../../model/on_boarding/on_boarding.dart';
import '../../../../model/on_boarding/referency.dart';
import '../views/age.dart';
import '../views/gender.dart';
import '../views/preferences.dart';

class OnBoardingController extends GetxController {
  final PageController pageController = PageController();
  final Rx<int> currentPage = 0.obs;
  final Rx<int> selectedIndexGender = 0.obs;
  final Rx<int> selectedIndexAge = 0.obs;

  final listGender = <ModelGender>[
    ModelGender(title: 'Laki-laki', imageAssets: KeysAssetsImages.maleGender),
    ModelGender(title: 'Perempuan', imageAssets: KeysAssetsImages.femaleGender),
  ];

  final listAge = ['18-24', '25-34', '35-44', '45-54', '55+'];

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
    } else if (currentPage.value == 2 &&
        listPreferences.any((element) => element.isSelected.value == true)) {
      simpan();
    } else if (currentPage.value == 2 &&
        listPreferences.any((element) => element.isSelected.value == false)) {
      Get.snackbar(
        'Info',
        'Silakan pilih kategori buku terlebih dahulu',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.grey,
        colorText: Colors.white,
      );
    }
  }

  void simpan() {
    tampilkanSemuaNilai();
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
  void onInit() {
    currentPage.value = 0;
    super.onInit();
  }
}
