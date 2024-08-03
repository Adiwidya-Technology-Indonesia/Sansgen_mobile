import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import '../../../../../provider/auth.dart';
import '../../../../../services/prefs.dart';

class RegisterController extends GetxController {
  final AuthProvider authProvider;
  final PrefService prefService;

  RegisterController({required this.authProvider, required this.prefService});

  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final komfirPassController = TextEditingController();

  void backToLogin() {
    Get.back();
  }

  bool nullValidation(String? value) {
    if (value == null || value.trim().isEmpty) {
      return true;
    }
    return false;
  }

  String? validateName(String? name) {
    if (nullValidation(name)) {
      return 'Nama harap di isi';
    }
    return '';
  }

  String? validateEmail(String? email) {
    if (nullValidation(email)) {
      return 'Email harap di isi';
    }
    // Regex untuk validasi email
    String pattern = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$';
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(email!)) {
      return 'Format email tidak valid';
    }
    return '';
  }

  // Berfungsi untuk memvalidasi password
  String? validatePassword(String? password) {
    // Reset pesan kesalahan
    String errorMessage = '';
    // Panjang kata sandi lebih dari 6
    if (password!.length < 8) {
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
      return '';
    } else {
      return errorMessage;
    }
  }

  // Fungsi untuk memvalidasi konfirmasi password
  String? validateConfirmPassword(String? confirmPassword) {
    if (nullValidation(confirmPassword)) {
      return 'Konfirmasi kata sandi harap di isi';
    }
    if (passwordController.text != confirmPassword) {
      return 'Kata sandi tidak cocok';
    }
    return '';
  }

  Future register() async {
    try {
      // Cek apakah ada pesan kesalahan
      final formError = formKey.currentState!.validateGranularly().toList();
      if (formError.isNotEmpty) {
        return Get.snackbar(
          "Ups!",
          "Sepertinya ada beberapa field yang terlewat. Yuk, lengkapi dulu!",
        );
      }
      log(
        '${nameController.text} ${emailController.text} ${passwordController.text} ${komfirPassController.text}',
        name: 'form value',
      );
      EasyLoading.show(status: 'loading...');
      final response = await authProvider.authRegister(
        nameController.text,
        emailController.text,
        passwordController.text,
      );
      if (response.success == true) {
        EasyLoading.dismiss();
        formCLear();
        EasyLoading.showSuccess('Register berhasil');
        log(response.toJson().toString(), name: 'register');
      } else {
        EasyLoading.showError('Register gagal');
      }
    } catch (e) {
      log(e.toString(), name: 'register error');
      Get.defaultDialog(
        title: 'Error',
        content: Text('Error: $e'),
      );
    }
  }

  void formCLear() {
    nameController.clear();
    emailController.clear();
    passwordController.clear();
    komfirPassController.clear();
  }

  @override
  void onInit() {
    prefService.removeUserToken();
    super.onInit();
  }
}
