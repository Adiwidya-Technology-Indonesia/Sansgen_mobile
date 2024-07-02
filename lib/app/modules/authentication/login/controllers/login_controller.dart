import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../provider/auth.dart';

class LoginController extends GetxController {
  final AuthProvider authProvider = AuthProvider();
  final userNameController = TextEditingController();
  final passwordController = TextEditingController();
  var isUserNameMessage = ''.obs;
  var isPasswordMessage = ''.obs;

  bool nullValidation(String? value) {
    if (value == null || value.trim().isEmpty) {
      return true;
    }
    return false;
  }

  String _validateUserName(String userName) {
    if (nullValidation(userNameController.text)) {
      return isUserNameMessage.value = 'nama user harap di isi';
    } else {
      return isUserNameMessage.value = '';
    }
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

  Future login() async {
    try {
      _validateUserName(userNameController.text);
      _validatePassword(passwordController.text);
      final response = await authProvider.login(
        userNameController.text,
        passwordController.text,
      );
      log(response.toJson().toString());
    } catch (e) {
      Get.defaultDialog(
        title: 'Error',
        content: Text('Error: $e'),
      );
    }
  }
}
