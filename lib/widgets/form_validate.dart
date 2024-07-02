import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sansgen/utils/ext_context.dart';

class FormValidate extends StatelessWidget {
  const FormValidate({
    Key? key,
    required this.title,
    required this.hint,
    required this.icon,
    required this.controller,
    required this.info,
    this.keyboardType,
  }) : super(key: key);
  final String title;
  final String hint;
  final String icon;
  final TextEditingController controller;
  final String? info;
  final TextInputType? keyboardType;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: context.labelLargeBold,
        ),
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
            hintText: hint,
            prefixIcon: SvgPicture.asset(
              icon,
            ),
            prefixIconConstraints: const BoxConstraints(
              minWidth: 16,
              minHeight: 16,
            ),
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
