import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:sansgen/utils/ext_context.dart';

import '../controllers/on_boarding_controller.dart';

class PreferenciView extends GetView<OnBoardingController> {
  const PreferenciView({super.key});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      direction: Axis.horizontal,
      spacing: 20.0,
      runSpacing: 20.0,
      children: controller.listPreferences.asMap().entries.map((entry) {
        int index = entry.key;
        var e = entry.value;
        return Obx(
          () => cardBorder(
            title: e.title,
            isSelected: e.isSelected.value,
            context: context,
            color: e.isSelected.value == true
                ? context.colorScheme.surface
                : context.colorScheme.background,
            index: index,
            onTap: () {
              e.isSelected.value = true;
            },
          ),
        );
      }).toList(),
    );
  }

  GestureDetector cardBorder({
    required BuildContext context,
    required String title,
    required Function() onTap,
    required Color color,
    required int index,
    required bool isSelected,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 30,
        // width: 100,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        decoration: BoxDecoration(
          border: Border.all(
            color: context.colorScheme.outline,
            width: 1.0,
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
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Checkbox(
            //   value: isSelected,
            //   onChanged: (value) {
            //     isSelected = value ?? false;
            //   },
            // ),
            SizedBox(
              width: 12,
              height: 12,
              child: Card(
                color: color,
                margin: const EdgeInsets.all(0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  side: BorderSide(
                    color: context.colorScheme.outline,
                    width: 1.0,
                  ),
                ),
              ),
            ),
            const Gap(12),
            Text(title),
          ],
        ),
      ),
    );
  }
}
