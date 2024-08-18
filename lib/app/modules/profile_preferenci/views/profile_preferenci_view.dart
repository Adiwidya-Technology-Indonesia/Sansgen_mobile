import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import 'package:get/get.dart';
import 'package:sansgen/app/routes/app_pages.dart';
import 'package:sansgen/utils/ext_context.dart';
import 'package:sansgen/widgets/avatar_widget.dart';

import '../../../../widgets/card_preference.dart';
import '../../../routes/app_pages.dart';
import '../controllers/profile_preferenci_controller.dart';

class ProfilePreferenciView extends GetView<ProfilePreferenciController> {
  const ProfilePreferenciView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return controller.obx((state) => Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: context.colorScheme.primary,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: ()=> Get.offAllNamed(Routes.DASHBOARD,arguments: 3),
                  child: AvatarWidget(
                    image: state!.image,
                    height: 50.0,
                    width: 50,
                  ),
                ),
                const Text(
                  'Referensi Kamu',
                  style: TextStyle(fontSize: 24),
                ),
                const SizedBox(
                  height: 50.0,
                  width: 50,
                ),
              ],
            ),
            centerTitle: true,
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Column(
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
              ],
            ),
          ),
          resizeToAvoidBottomInset: false,
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          floatingActionButton: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: ElevatedButton(
              onPressed: () {
                controller.simpan();
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                minimumSize: const Size(double.infinity, 50),
              ),
              child: Text(
                'Simpan',
                style: context.titleMedium
                    .copyWith(color: context.colorScheme.primary),
              ),
            ),
          ),
        ));
  }
}
