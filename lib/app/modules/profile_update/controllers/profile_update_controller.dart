import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:sansgen/app/routes/app_pages.dart';
import 'package:sansgen/model/user/user.dart';
import 'package:sansgen/utils/ext_context.dart';

import '../../../../model/error.dart';
import '../../../../model/user/request_patch_user.dart';
import '../../../../provider/user.dart';
import 'image_profil_controller.dart';

class ProfileUpdateController extends GetxController {
  // final AuthProvider authProvider;
  // final PrefService prefService;
  ProfileUpdateController({required this.userProvider});
  final UserProvider userProvider;
  DateTime selectedDate = DateTime.now();
  final nameController = TextEditingController();
  final hobbyController = TextEditingController();
  final tglLahirController = TextEditingController();
  DateTime? picked;

  var isNameMessage = ''.obs;
  var isjkelMessage = ''.obs;
  var istglLahirMessage = ''.obs;
  late ModelUser user;

  @override
  void onInit() {
    if (Get.arguments != null) {
      user = Get.arguments;
      nameController.text = user.name;
      hobbyController.text = user.gender ?? 'Jenis kelamin';
      tglLahirController.text = user.dateOfBirth;
    } else {
      user = ModelUser.fromJson({});
    }
    super.onInit();
  }

  bool nullValidation(String? value) {
    if (value == null || value.trim().isEmpty) {
      return true;
    }
    return false;
  }

  String validateName(String value) {
    if (nullValidation(value)) {
      return isNameMessage.value = 'Nama harap di isi';
    } else {
      return isNameMessage.value = '';
    }
  }

  String validateJkel(String value) {
    if (nullValidation(value)) {
      return isjkelMessage.value = 'Jenis Kelamin harap di isi';
    }
    return isjkelMessage.value = '';
  }

  String validateTglLahir(String value) {
    if (nullValidation(value)) {
      return istglLahirMessage.value = 'Tanggal Lahir harap di isi';
    }
    return istglLahirMessage.value = '';
  }

  Future profilUpdateButton() async {
    try {
      String imageName = '';
      final imageController = Get.find<ImageUpdateController>();
      // final categorySelesai = listPreferences.where((e)=>e.isSelected.value == true).toList().map((v)=>v.title);
      if (imageController.imageFileList.isNotEmpty) {
        imageName = imageController.imageFileList.first.name;
      } else {
        imageName = '';
      }
      log(imageName, name: 'imageName');
      final request = ModelRequestPatchUser(
        name: nameController.text,
        gender: hobbyController.text,
        dateOfBirth: picked ?? DateTime.now(),
        image: imageName,
      );
      userProvider.patchInfoPribadi(request).then((v) async {
        EasyLoading.dismiss();
        EasyLoading.showSuccess('Update Data berhasil');
        log(v.toJson().toString());
        Get.offAllNamed(Routes.DASHBOARD,arguments: 3);
        return;
      }).onError((e, st) {
        EasyLoading.dismiss();
        final errors = Errors(message: ['$e', '$st']);
        final dataError = ModelResponseError(errors: errors);
        log(dataError.toJson().toString());
        EasyLoading.showError('Update Data Gagal');
        return;
      });
    } catch (e) {
      Get.defaultDialog(
        title: 'Error',
        content: Text('Error: $e'),
      );
    }
  }

  Future datePick({
    required BuildContext context,
    // required DateTime selectedDate,
  }) async {
    picked = await showDatePicker(
      builder: (ctx,child){
        return Theme(
          data: Theme.of(ctx).copyWith(
            colorScheme: ColorScheme.light(
              primary: ctx.colorScheme.surface, // header background color
              onPrimary: ctx.colorScheme.primary, // header text color
              onSurface: ctx.colorScheme.surface, // body text color
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: Colors.red, // button text color
              ),
            ),
          ), child: child!);
      },
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(1900),
      lastDate: DateTime(2500),
    );

    if (picked != null) {
      tglLahirController.text = "${picked?.toLocal()}".split(' ')[0];
      log(tglLahirController.text, name: 'selectedDate');
      log(picked.toString(), name: 'selectedDate');
    }
  }

  void formCLear() {
    nameController.clear();
    hobbyController.clear();
    tglLahirController.clear();
  }
}
