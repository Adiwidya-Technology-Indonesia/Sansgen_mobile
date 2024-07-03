import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:sansgen/utils/ext_context.dart';

class AgeView extends StatelessWidget {
  const AgeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        cardBorder(
          title: '18 - 24',
          context: context,
        ),
        const Gap(20),
        cardBorder(
          title: '25 - 34',
          context: context,
        ),
        const Gap(20),
        cardBorder(
          title: '35 - 44',
          context: context,
        ),
        const Gap(20),
        cardBorder(
          title: '45 - 54',
          context: context,
        ),
        const Gap(20),
        cardBorder(
          title: '55+',
          context: context,
        ),
      ],
    );
  }

  Container cardBorder({
    required BuildContext context,
    required String title,
  }) {
    return Container(
      height: 60,
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(
          color: context.colorScheme.outline,
          width: 2.0,
          style: BorderStyle.solid,
        ),
        borderRadius: const BorderRadius.all(Radius.circular(10.0)),
        boxShadow: [
          BoxShadow(
            color: context.colorScheme.onSecondary,
            offset: const Offset(12.0, 4.0),
            spreadRadius: 1.0,
            blurRadius: 2.0,
          ),
          BoxShadow(
            color: context.colorScheme.background,
            offset: const Offset(12.0, 4.0),
            spreadRadius: -0.5,
            blurRadius: 2.0,
          ),
          BoxShadow(
            color: context.colorScheme.background,
            offset: const Offset(0.0, 0.0),
            spreadRadius: -1.0,
            blurRadius: 2.0,
          ),
        ],
      ),
      child: Center(child: Text(title)),
    );
  }
}
