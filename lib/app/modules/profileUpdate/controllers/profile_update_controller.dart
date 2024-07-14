import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

class ProfileUpdateController extends GetxController {
  // final AuthProvider authProvider;
  // final PrefService prefService;
  // ProfileUpdateController({required this.authProvider, required this.prefService});

  final nameController = TextEditingController();
  final jkelController = TextEditingController();
  final tglLahirController = TextEditingController();
 
  var isNameMessage = ''.obs;
  var isjkelMessage = ''.obs;
  var istglLahirMessage = ''.obs;

  bool nullValidation(String? value) {
    if (value == null || value.trim().isEmpty) {
      return true;
    }
    return false;
  }

  String _validateName(String value) {
    if (nullValidation(value)) {
      return isNameMessage.value = 'Nama harap di isi';
    } else {
      return isNameMessage.value = '';
    }
  }

  String _validateJkel(String value) {
    if (nullValidation(value)) {
      return isjkelMessage.value = 'Jenis Kelamin harap di isi';
    }
    return isjkelMessage.value = '';
  }

  String _validateTglLahir(String value) {
    if (nullValidation(value)) {
      return istglLahirMessage.value = 'Tanggal Lahir harap di isi';
    }
    return istglLahirMessage.value = '';
  }

  Future profilUpdateButton() async {
    try {
      _validateName(nameController.text);
      _validateJkel(jkelController.text);
      _validateTglLahir(tglLahirController.text);

      // Cek apakah ada pesan kesalahan
      if (isNameMessage.value.isEmpty &&
          isjkelMessage.value.isEmpty &&
          istglLahirMessage.value.isEmpty) {
        log(
          '${nameController.text} ${jkelController.text} ${tglLahirController.text}',
          name: 'form value',
        );
        EasyLoading.show(status: 'loading...');

        const oneSec = Duration(seconds: 3);
        Timer.periodic(oneSec, (time) {
          formCLear();
          EasyLoading.dismiss();
          time.cancel();
        });
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
    jkelController.clear();
    tglLahirController.clear();
  }
}
