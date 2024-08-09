import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import 'package:get/get.dart';
import 'package:sansgen/utils/ext_context.dart';

import '../../../../widgets/card_preference.dart';
import '../controllers/profile_preferenci_controller.dart';

class ProfilePreferenciView extends GetView<ProfilePreferenciController> {
  const ProfilePreferenciView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: Row(
            children: [
              const Gap(16),
              GestureDetector(
                  onTap: Get.back,
                  child: CircleAvatar(
                    child: Image.asset('assets/images/male_gender.png'),
                  )),
            ],
          ),
          backgroundColor: context.colorScheme.primary,
          title: const Text(
            'Referensi Kamu',
            style: TextStyle(fontSize: 24),
          ),
          centerTitle: true,
        ),
        body: Column(
          children: [
            const Gap(32),
            Text(
              'Pilih kategori buku yang kamu sukai',
              style: context.titleLarge,
            ),
            const Gap(64),
            Center(
              child: Wrap(
                direction: Axis.horizontal,
                spacing: 20.0,
                runSpacing: 20.0,
                children:
                    controller.listPreferences.asMap().entries.map((entry) {
                  int index = entry.key;
                  var e = entry.value;
                  return Obx(
                    () => cardPreference(
                      title: e.title,
                      isSelected: e.isSelected.value,
                      context: context,
                      color: e.isSelected.value == true
                          ? context.colorScheme.surface
                          : context.colorScheme.primary,
                      index: index,
                      onTap: () {
                        e.isSelected.value = true;
                      },
                    ),
                  );
                }).toList(),
              ),
            ),
            Gap(450),
             ElevatedButton(
                  onPressed:(){},
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    minimumSize: const Size(350, 50),
                  ),
                  child: Text(
                    'Simpan',
                    style: context.titleMedium
                        .copyWith(color: context.colorScheme.primary),
                  ),
                )
          ],
        ));
  }
}
