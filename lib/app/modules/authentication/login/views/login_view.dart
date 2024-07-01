// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:sansgen/utils/ext_context.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('LoginView'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Obx(
          () => Column(
            children: [
              Text(
                'Masuk',
                style: context.titleMediumBold,
              ),
              FormValidate(
                title: 'User',
                controller: controller.userNameController,
                info: controller.isUserNameMessage.value,
                keyboardType: TextInputType.name,
              ),
              FormValidate(
                title: 'Password',
                controller: controller.passwordController,
                info: controller.isPasswordMessage.value,
                keyboardType: TextInputType.visiblePassword,
              ),
              ElevatedButton(
                onPressed: controller.login,
                child: const Text('Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class FormValidate extends StatelessWidget {
  const FormValidate({
    Key? key,
    required this.title,
    required this.controller,
    required this.info,
    this.keyboardType,
  }) : super(key: key);
  final String title;
  final TextEditingController controller;
  final String? info;
  final TextInputType? keyboardType;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          validator: (value) {
            if (nullValidation(value)) {
              return "Harap di isi";
            }
            return null;
          },
          decoration: InputDecoration(
            labelText: title,
          ),
        ),
        Visibility(
          visible: info != null,
          child: Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Text(
              info ?? "",
              style: context.formError,
            ),
          ),
        ),
      ],
    );
  }

  bool nullValidation(String? value) {
    if (value == null || value.trim().isEmpty) {
      return true;
    }
    return false;
  }
}
