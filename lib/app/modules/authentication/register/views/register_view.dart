import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import 'package:get/get.dart';
import 'package:sansgen/utils/ext_context.dart';

import '../../../../../keys/assets_icons.dart';
import '../../../../../widgets/form_validate.dart';
import '../controllers/register_controller.dart';

class RegisterView extends GetView<RegisterController> {
  const RegisterView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Obx(
          () => Column(
            children: [
              const Gap(60),
              Text(
                'Daftar',
                style: context.titleLargeBold,
              ),
              const Gap(100),
              FormValidate(
                title: 'Email',
                hint: 'Masukan email',
                icon: KeysAssetsIcons.email,
                controller: controller.emailController,
                info: controller.isEmailMessage.value,
                keyboardType: TextInputType.name,
              ),
              FormValidate(
                title: 'Password',
                hint: 'Masukan password',
                icon: KeysAssetsIcons.pass,
                controller: controller.passwordController,
                info: controller.isPasswordMessage.value,
                keyboardType: TextInputType.visiblePassword,
              ),
              FormValidate(
                title: 'Confirm password',
                hint: 'Masukan kembali password',
                icon: KeysAssetsIcons.pass,
                controller: controller.komfirPassController,
                info: controller.isKomfirPassMessage.value,
                keyboardType: TextInputType.visiblePassword,
              ),
              const Gap(40),
              ElevatedButton(
                onPressed: controller.register,
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 40),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text('Masuk'),
              ),
              const Spacer(),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('Sudah memiliki akun? '),
                  InkWell(
                    onTap: controller.backToLogin,
                    child: Text('Sing In', style: context.titleSmallBold),
                  ),
                ],
              ),
              const Gap(60),
            ],
          ),
        ),
      ),
    );
  }
}
