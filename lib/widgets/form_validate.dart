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
    required this.validator,
    this.keyboardType,
    this.color,
  }) : super(key: key);
  final String title;
  final String hint;
  final String icon;
  final TextEditingController controller;

  // final String? info;
  final TextInputType? keyboardType;
  final ColorFilter? color;
  final String? Function(String?)? validator;

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
          textInputAction: TextInputAction.done,
          validator: validator,
          cursorColor: context.colorScheme.surface,
          // onChanged: ,
          decoration: InputDecoration(
            alignLabelWithHint: false,
            hintText: hint,
            prefixIcon: SvgPicture.asset(
              icon,
              colorFilter: color,
            ),
            prefixIconConstraints: const BoxConstraints(
              minWidth: 16,
              minHeight: 16,
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: context.colorScheme.onPrimary,
              ),
            ),
          ),
        ),

      ],
    );
  }
}
