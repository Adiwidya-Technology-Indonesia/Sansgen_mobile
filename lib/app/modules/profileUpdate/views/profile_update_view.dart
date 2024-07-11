// import 'dart:nativewrappers/_internal/vm/lib/internal_patch.dart';

// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import 'package:get/get.dart';
import 'package:sansgen/model/image_hash.dart';
import 'package:sansgen/utils/ext_context.dart';

import '../controllers/profile_update_controller.dart';
import 'wrapper_up_profile.dart';

class ProfileUpdateView extends GetView<ProfileUpdateController> {
  const ProfileUpdateView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colorScheme.secondary.withOpacity(0.1),
      appBar: appBarProUpdate(context),
      body: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Informasi Pribadi',
              style: context.titleLargeBold
                  .copyWith(color: context.colorScheme.onPrimary),
            ),
            const Gap(20),
            textFieldProUpdate(hintText: 'Nama Lengkap', context: context),
            textFieldProUpdate(hintText: 'Jenis Kelamin', context: context),
            textFieldProUpdate(hintText: 'Tanggal Lahir', context: context),
            textFieldProUpdate(hintText: 'Email', context: context),
            const Spacer(),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
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
    );
  }

  Padding textFieldProUpdate(
      {required String hintText, required BuildContext context}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: TextFormField(
        decoration: InputDecoration(
          filled: true,
          fillColor: context.colorScheme.primary,
          label: Text(
            hintText,
            style: context.titleMedium
                .copyWith(color: context.colorScheme.surface),
          ),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none),
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
