import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:sansgen/app/routes/app_pages.dart';
import '../../../../../provider/auth.dart';
import '../../../../../services/prefs.dart';

class LoginController extends GetxController {
  final AuthProvider authProvider;
  final PrefService prefService;
  LoginController({required this.authProvider, required this.prefService});

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  var isEmailMessage = ''.obs;
  var isPasswordMessage = ''.obs;

  void onTapSignUp() {
    Get.toNamed(Routes.REGISTER);
  }

  void onTapLupaPass() {
    Get.toNamed(Routes.LUPA_PASS);
  }

  bool nullValidation(String? value) {
    if (value == null || value.trim().isEmpty) {
      return true;
    }
    return false;
  }

  // Berfungsi untuk memvalidasi password
  String _validatePassword(String password) {
    // Reset pesan kesalahan
    String errorMessage = '';
    // Panjang kata sandi lebih dari 6
    if (password.length < 8) {
      errorMessage += 'Kata sandi minimal 8 karakter.\n';
    }
    // Berisi setidaknya satu huruf besar
    if (!password.contains(RegExp(r'[A-Z]'))) {
      errorMessage += '• Huruf besar tidak ada.\n';
    }
    // Berisi setidaknya satu huruf kecil
    if (!password.contains(RegExp(r'[a-z]'))) {
      errorMessage += '• Huruf kecil tidak ada.\n';
    }
    // Berisi setidaknya satu digit
    if (!password.contains(RegExp(r'[0-9]'))) {
      errorMessage += '• Angka tidak ada.\n';
    }
    // Berisi setidaknya satu karakter khusus
    if (!password.contains(RegExp(r'[!@#%^&*(),.?":{}|<>]'))) {
      errorMessage += '• Karakter khusus tidak ada.\n';
    }
    // Jika tidak ada pesan kesalahan, kata sandi valid
    if (errorMessage.isEmpty) {
      return isPasswordMessage.value = '';
    } else {
      return isPasswordMessage.value = errorMessage;
    }
  }

  String _validateEmail(String email) {
    if (nullValidation(email)) {
      return isEmailMessage.value = 'Email harap di isi';
    }
    // Regex untuk validasi email
    String pattern = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$';
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(email)) {
      return isEmailMessage.value = 'Format email tidak valid';
    }
    return isEmailMessage.value = '';
  }

  Future login() async {
    try {
      _validateEmail(emailController.text);
      _validatePassword(passwordController.text);
      if (isEmailMessage.value.isEmpty && isPasswordMessage.value.isEmpty) {
        EasyLoading.show(status: 'loading...');
        final response = await authProvider.authLogin(
          emailController.text,
          passwordController.text,
        );
        if (response.success == true) {
          EasyLoading.dismiss();
          formClear();
          EasyLoading.showSuccess('Login berhasil');
          prefService.putUserToken(response.data!.token);
          log(response.toJson().toString());
        } else {
          EasyLoading.showError('Login gagal');
        }
      }
    } catch (e) {
      Get.defaultDialog(
        title: 'Error',
        content: Text('Error: $e'),
      );
    }
  }

  void formClear() {
    emailController.clear();
    passwordController.clear();
  }

  @override
  void onInit() {
    prefService.removeUserToken();
    super.onInit();
  }
}
