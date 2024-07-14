// import 'dart:nativewrappers/_internal/vm/lib/internal_patch.dart';

// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import 'package:get/get.dart';
import 'package:sansgen/model/image_hash.dart';
import 'package:sansgen/utils/ext_context.dart';
import 'package:sansgen/widgets/update_profil_form_validate.dart';

import '../controllers/profile_update_controller.dart';
import 'wrapper_up_profile.dart';

class ProfileUpdateView extends GetView<ProfileUpdateController> {
  const ProfileUpdateView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colorScheme.secondary.withOpacity(0.1),
      appBar: appBarProUpdate(context),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Obx(
            () => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Informasi Pribadi',
                  style: context.titleLargeBold
                      .copyWith(color: context.colorScheme.onPrimary),
                ),
                const Gap(20),
                UpdateProfilFormValidate(
                  hintText: 'Nama Lengkap',
                  controller: controller.nameController,
                  info: controller.isNameMessage.value,
                ),
                UpdateProfilFormValidate(
                  hintText: 'Jenis Kelamin',
                  controller: controller.jkelController,
                  info: controller.isjkelMessage.value,
                ),
                UpdateProfilFormValidate(
                  hintText: 'Tanggal Lahir',
                  controller: controller.tglLahirController,
                  info: controller.istglLahirMessage.value,
                ),
                Gap(context.height * 0.12),
                ElevatedButton(
                  onPressed: controller.profilUpdateButton,
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
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  AppBar appBarProUpdate(BuildContext context) {
    return AppBar(
      leading: IconButton(
        onPressed: () => Get.back(),
        icon: Icon(
          Icons.arrow_back_ios_new,
          color: context.colorScheme.primary,
        ),
      ),
      backgroundColor: Colors.transparent,
      flexibleSpace: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                context.colorScheme.onSecondaryContainer,
                context.colorScheme.primaryContainer
              ],
              stops: const [0.0, 1.0],
              begin: Alignment.topLeft,
              // end: Alignment.bottomRight,
            ),
            borderRadius:
                const BorderRadius.vertical(bottom: Radius.circular(20))),
      ),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            width: double.infinity,
          ),
          Text(
            'Edit Profile',
            style: context.titleLargeBold
                .copyWith(color: context.colorScheme.primary),
          ),
        ],
      ),
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(280),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Siapkan Profil Anda',
                style: context.titleLarge
                    .copyWith(color: context.colorScheme.primary)),
            const Gap(20),
            WrapperImageUpdateProfil(
              image: ImageHash(
                imageUrl:
                    'https://www.static-src.com/wcsstore/Indraprastha/images/catalog/full//94/MTA-75108153/no-brand_buku-jangan-mulai-bisnis-sebelum-baca-buku-ini-cara-sederhana-tapi-am_full01.jpg',
                imageHash: 'LEHV6nWB2yk8pyo0adR*.7kCMdnj',
              ),
            ),
            // Stack(
            //   alignment: Alignment.bottomRight,
            //   children: [
            //     GestureDetector(
            //       onTap:(){},
            //       child: CircleAvatar(
            //         radius: 80,
            //         child: SvgPicture.asset(
            //           KeysAssetsIcons.user,
            //           width: 50,
            //           height: 50,
            //         ),
            //       ),
            //     ),
            //     CircleAvatar(
            //       backgroundColor: context.colorScheme.onSecondary,
            //       child: SvgPicture.asset(KeysAssetsIcons.camera,
            //           width: 20, height: 20),
            //     )
            //   ],
            // ),
            const Gap(50)
          ],
        ),
      ),
    );
  }
}
