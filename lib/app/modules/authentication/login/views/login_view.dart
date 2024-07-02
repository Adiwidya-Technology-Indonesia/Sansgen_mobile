import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import 'package:sansgen/utils/ext_context.dart';
import '../../../../../keys/assest_icons.dart';
import '../../../../../keys/assest_images.dart';
import '../../../../../widgets/form_validate.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({Key? key}) : super(key: key);
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
                'Masuk',
                style: context.titleLargeBold,
              ),
              const Gap(60),
              FormValidate(
                title: 'Email',
                hint: 'Masukan email',
                icon: KeysAssestIcons.email,
                controller: controller.userNameController,
                info: controller.isUserNameMessage.value,
                keyboardType: TextInputType.name,
              ),
              FormValidate(
                title: 'Password',
                hint: 'Masukan password',
                icon: KeysAssestIcons.pass,
                controller: controller.passwordController,
                info: controller.isPasswordMessage.value,
                keyboardType: TextInputType.visiblePassword,
              ),
              Align(
                heightFactor: 0.2,
                alignment: Alignment.centerRight,
                child: InkWell(
                  onTap: () {},
                  child: Text(
                    'Lupa Password?',
                    style: context.titleMediumBold,
                  ),
                ),
              ),
              const Gap(40),
              ElevatedButton(
                onPressed: controller.login,
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 40),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text('Masuk'),
              ),
              const Gap(40),
              const Text('Atau gunakan'),
              const Gap(20),
              InkWell(
                onTap: () {},
                child: SvgPicture.asset(
                  KeysAssestImages.google,
                  width: 40,
                  height: 40,
                ),
              ),
              const Spacer(),
              RichText(
                text: TextSpan(
                  text: 'Belum memiliki akun? ',
                  children: [
                    TextSpan(
                      text: 'Sing Up',
                      style: context.titleSmallBold,
                    ),
                  ],
                ),
                textAlign: TextAlign.center,
              ),
              const Gap(60),
            ],
          ),
        ),
      ),
    );
  }
}
