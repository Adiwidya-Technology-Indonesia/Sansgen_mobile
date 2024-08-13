import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:sansgen/keys/assets_icons.dart';
import 'package:sansgen/utils/ext_context.dart';

import '../../../routes/app_pages.dart';
import '../controllers/profil_controller.dart';

class ProfilView extends GetView<ProfilController> {
  const ProfilView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarCustom(context),
      body: ListView(
        children: [
          const Gap(40),
          profilCard(
            title: 'Informasi Pribadi',
            context: context,
            iconCom: KeysAssetsIcons.user,
            onTap: () {
              Get.toNamed(Routes.PROFILE_UPDATE);
            },
          ),
          profilCard(
            title: 'Kategori favorit',
            context: context,
            iconCom: KeysAssetsIcons.category,
            onTap: () {
              Get.toNamed(Routes.PROFILE_PREFERENCI);
            },
          ),
          profilCard(
              title: 'Payment',
              context: context,
              iconCom: KeysAssetsIcons.payment,
              onTap: () => Get.toNamed(Routes.PAYMENT_BUY)
            ),
            profilCard(
              title: 'Tentang Sansgen',
              context: context,
              iconCom: KeysAssetsIcons.info,
              onTap: () {},
            ),
            profilCard(
              title: 'Keluar',
              context: context,
              iconCom: KeysAssetsIcons.logOut,
              onTap: () => controller.logOutButton(context),
            ),
          ],
        ));

  }

  AppBar appBarCustom(BuildContext context) {
    return AppBar(
      toolbarHeight: 300,
      backgroundColor: context.colorScheme.primary,
      centerTitle: true,
      flexibleSpace: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              context.colorScheme.onSecondaryContainer,
              context.colorScheme.primaryContainer
            ],
            stops: const [0.0, 1.0],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: const BorderRadius.vertical(
            bottom: Radius.circular(20),
          ),
        ),
      ),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {
              Get.dialog(
                GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: Image.asset('assets/images/male_gender.png'),
                ),
              );
            },
            child: SizedBox(
              height: 150,
              width: 150,
              child: CircleAvatar(
                child: Image.asset('assets/images/male_gender.png'),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            "Muh Wais",
            style: context.titleLargeBold.copyWith(
              color: context.colorScheme.primary,
            ),
          )
        ],
      ),
    );
  }

  GestureDetector profilCard(
      {required String title,
      required BuildContext context,
      required String iconCom,
      required void Function()? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        height: 50,
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 28),
          child: Row(
            children: [
              SvgPicture.asset(
                iconCom,
                width: 24,
                colorFilter: ColorFilter.mode(
                  context.colorScheme.surface,
                  BlendMode.srcIn,
                ),
              ),
              const Gap(20),
              Text(
                title,
                style: context.titleMedium,
              )
            ],
          ),
        ),
      ),
    );
  }
}
