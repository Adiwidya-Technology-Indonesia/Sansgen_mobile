import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:sansgen/keys/assets_icons.dart';
import 'package:sansgen/utils/ext_context.dart';
import 'package:sansgen/widgets/avatar_widget.dart';

import '../../../../state/empty.dart';
import '../../../../state/error.dart';
import '../../../../state/loading.dart';
import '../../../routes/app_pages.dart';
import '../controllers/profil_controller.dart';

class ProfilView extends GetView<ProfilController> {
  const ProfilView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return controller.obx(
      (state) => Scaffold(
        appBar: appBarCustom(
            context: context, name: state!.name, image: state.image!),
        body: ListView(
          children: [
            const Gap(20),
            profilCard(
              title: 'Informasi Pribadi',
              context: context,
              iconCom: KeysAssetsIcons.user,
              onTap: () {
                Get.offAllNamed(Routes.PROFILE_UPDATE, arguments: state);
              },
            ),
            profilCard(
              title: 'Kategori favorit',
              context: context,
              iconCom: KeysAssetsIcons.category,
              onTap: () {
                Get.offAllNamed(
                  Routes.PROFILE_PREFERENCI,
                );
              },
            ),
            profilCard(
              title: 'Payment',
              context: context,
              iconCom: KeysAssetsIcons.payment,
              onTap: () =>
                  Get.offAllNamed(Routes.PAYMENT_BUY, arguments: state),
            ),
            // profilCard(
            //   title: 'Tentang Sansgen',
            //   context: context,
            //   iconCom: KeysAssetsIcons.info,
            //   onTap: () {},
            // ),
            profilCard(
              title: 'Keluar',
              context: context,
              iconCom: KeysAssetsIcons.logOut,
              onTap: () => controller.logOutButton(context),
            ),
          ],
        ),
      ),
      onLoading: const LoadingState(),
      onError: (error) => ErrorState(error: error.toString()),
      onEmpty: const EmptyState(),
    );
  }

  AppBar appBarCustom({
    required BuildContext context,
    required String name,
    required String image,
  }) {
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
                    child: AvatarWidget(
                      image: image,
                    ),
                  ),
                );
              },
              child: AvatarWidget(
                image: image,
                height: 150,
                width: 150,
              )),
          const SizedBox(
            height: 20,
          ),
          Text(
            name,
            style: context.titleLargeBold.copyWith(
              color: context.colorScheme.primary,
            ),
          )
        ],
      ),
    );
  }

  GestureDetector profilCard({
    required String title,
    required BuildContext context,
    required String iconCom,
    required void Function()? onTap,
    double? width,
    // double? gapIcon,
    double? height,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        height: 50,
        width: double.infinity,
        child: Row(
          children: [
            Row(
              children: [
                // Gap(gapIcon ?? 12),
                SvgPicture.asset(
                  alignment: Alignment.center,
                  iconCom,
                  width: width,
                  height: height,
                  colorFilter: ColorFilter.mode(
                    context.colorScheme.surface,
                    BlendMode.srcIn,
                  ),
                ),
              ],
            ),
            const Gap(20.0),
            Text(
              title,
              style: context.titleMedium,
            )
          ],
        ),
      ),
    );
  }
}
