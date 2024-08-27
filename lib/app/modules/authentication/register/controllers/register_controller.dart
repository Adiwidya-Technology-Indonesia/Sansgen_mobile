import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:sansgen/model/register/model_request_register.dart';

import '../../../../../model/error.dart';
import '../../../../../provider/auth.dart';
import '../../../../routes/app_pages.dart';

class RegisterController extends GetxController {
  final AuthProvider authProvider;

  RegisterController({required this.authProvider});

  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final komfirPassController = TextEditingController();

  final isObscurePass = true.obs;
  final isObscureComPass = true.obs;

  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    komfirPassController.dispose();
    super.onClose();
  }

  void stateObscurePass() => isObscurePass.value = !isObscurePass.value;
  void stateObscureComPass() => isObscureComPass.value = !isObscureComPass.value;

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
    // // Berisi setidaknya satu huruf besar
    // if (!password.contains(RegExp(r'[A-Z]'))) {
    //   errorMessage += '• Huruf besar tidak ada.\n';
    // }
    // // Berisi setidaknya satu huruf kecil
    // if (!password.contains(RegExp(r'[a-z]'))) {
    //   errorMessage += '• Huruf kecil tidak ada.\n';
    // }
    // // Berisi setidaknya satu digit
    // if (!password.contains(RegExp(r'[0-9]'))) {
    //   errorMessage += '• Angka tidak ada.\n';
    // }
    // // Berisi setidaknya satu karakter khusus
    // if (!password.contains(RegExp(r'[!@#%^&*(),.?":{}|<>]'))) {
    //   errorMessage += '• Karakter khusus tidak ada.\n';
    // }
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
      log(
        '${nameController.text} ${emailController.text} ${passwordController.text} ${komfirPassController.text}',
        name: 'form value',
      );
      // Cek apakah ada pesan kesalahan
      if (validateName(nameController.text) != '' &&
          validateEmail(emailController.text) != '' &&
          validatePassword(passwordController.text) != '' &&
          validateConfirmPassword(komfirPassController.text) != '') {
        return Get.snackbar(
          "Ups!",
          "Sepertinya ada beberapa field yang terlewat. Yuk, lengkapi dulu!",
        );
      }
      EasyLoading.show(status: 'loading...');
      final request = ModelReqestRegister(
        name: nameController.text,
        email: emailController.text,
        password: passwordController.text,
      );
      await authProvider.authRegister(request).then((v) {
        EasyLoading.dismiss();
        formCLear();
        EasyLoading.showSuccess('Register berhasil');
        Get.toNamed(Routes.LOGIN);
        log(v.toJson().toString(), name: 'register');
        return;
      }).onError((e, st) {
        EasyLoading.dismiss();
        final errors = Errors(message: ['$e', '$st']);
        final dataError = ModelResponseError(errors: errors);
        log(dataError.toJson().toString(), name: 'register');
        EasyLoading.showError('Register Gagal');
        return;
      });
    } catch (e) {
      log(e.toString(), name: 'register error');
      Get.defaultDialog(
        title: 'Error',
        content: Text('Error: $e'),
      );
      return;
    }
  }

  void formCLear() {
    nameController.clear();
    emailController.clear();
    passwordController.clear();
    komfirPassController.clear();
  }
}
