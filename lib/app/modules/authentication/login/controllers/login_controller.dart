import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:sansgen/app/routes/app_pages.dart';
import 'package:sansgen/model/error.dart';
import 'package:sansgen/model/login/request_login.dart';
import '../../../../../provider/auth.dart';
import '../../../../../services/prefs.dart';

class LoginController extends GetxController {
  final AuthProvider authProvider;
  final PrefService prefService;

  LoginController({required this.authProvider, required this.prefService});

  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final isObscure = true.obs;

  @override
  void onInit() async {
    await prefService.prefInit();
    await prefService.removeUserToken();
    super.onInit();
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  void stateObscure() => isObscure.value = !isObscure.value;

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

  Future login() async {
    try {
      if (validateEmail(emailController.text) != '' &&
          validatePassword(passwordController.text) != '') {
        return Get.snackbar(
          "Ups!",
          "Sepertinya ada beberapa field yang terlewat. Yuk, lengkapi dulu!",
        );
      }
      log('mulai');
      EasyLoading.show(status: 'loading...');
      final request = ModelReqestLogin(
        email: emailController.text,
        password: passwordController.text,
      );
      await authProvider.authLogin(request).then((v) async {
        EasyLoading.dismiss();
        formClear();
        EasyLoading.showSuccess('Login berhasil');
        await prefService.putUserToken(v.data.token);
        await prefService.putUserUuid(v.data.uuid);
        Timer.periodic(const Duration(seconds: 3), (t) {
          log(prefService.getUserToken ?? 'kosong', name: 'setToken');
          t.cancel();
        });
        log(v.toJson().toString());
        Get.offAllNamed(Routes.ON_BOARDING);
        return;
      }).onError((e, st) {
        EasyLoading.dismiss();
        final errors = Errors(message: ['$e', '$st']);
        final dataError = ModelResponseError(errors: errors);
        log(dataError.toJson().toString());
        EasyLoading.showError('Login Gagal');
        return;
      });
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
}
