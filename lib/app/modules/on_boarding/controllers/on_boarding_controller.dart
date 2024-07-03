import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../keys/assets_images.dart';
import '../../../routes/app_pages.dart';
import '../views/age.dart';
import '../views/gender.dart';
import '../views/preferences.dart';

class OnBoardingController extends GetxController {
  final PageController pageController = PageController();
  final Rx<int> currentPage = 0.obs;
  final Rx<int> selectedIndexGender = 0.obs;

  final listGender = <ModelGender>[
    ModelGender(title: 'Laki-laki', imageAssets: KeysAssetsImages.maleGender),
    ModelGender(title: 'Perempuan', imageAssets: KeysAssetsImages.femaleGender),
  ];
  final listAge = ['18-25', '26-35', '36-45', '46-55', '56-65', '66+'];
  final listPreferences = [
    'Bisnis',
    'Pengembangan diri',
    'Marketing & Sales',
    'Sains',
    'Filsafat',
    'Agama',
    'Politik',
    'Sejarah'
  ];
  final Rx<String> selectedGender = ''.obs;
  final Rx<String> selectedAge = ''.obs;
  final Rx<String> selectedPreferences = ''.obs;

  String setGender(String value) {
    selectedGender.value = value;
    return selectedGender.value;
  }

  String setAge(String value) {
    selectedAge.value = value;
    return selectedAge.value;
  }

  String setPreferences(String value) {
    selectedPreferences.value = value;
    return selectedPreferences.value;
  }

  void nextPage() {
    if (currentPage.value == 0 && selectedGender.isNotEmpty) {
      currentPage.value++;
    } else if (currentPage.value == 0 && selectedGender.isEmpty) {
      Get.snackbar(
        'Info',
        'Silakan pilih jenis kelamin terlebih dahulu',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } else if (currentPage.value == 1 && selectedAge.isNotEmpty) {
      currentPage.value++;
    } else if (currentPage.value == 1 && selectedAge.isEmpty) {
      Get.snackbar(
        'Info',
        'Silakan pilih umur terlebih dahulu',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } else if (currentPage.value == 2 && selectedPreferences.isNotEmpty) {
      simpan();
    } else if (currentPage.value == 2 && selectedPreferences.isEmpty) {
      Get.snackbar(
        'Info',
        'Silakan pilih kategori buku terlebih dahulu',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  void simpan() {
    if (selectedGender.isNotEmpty &&
        selectedAge.isNotEmpty &&
        selectedPreferences.isNotEmpty) {
      Get.toNamed(Routes.DASHBOARD);
    }
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

class ModelOnBoarding {
  final String title;
  final String titleAppBar;
  final String titleButton;
  final Widget page;

  ModelOnBoarding({
    required this.title,
    required this.titleAppBar,
    required this.titleButton,
    required this.page,
  });
}

class ModelGender {
  final String title;
  final String imageAssets;

  ModelGender({
    required this.title,
    required this.imageAssets,
  });
}
