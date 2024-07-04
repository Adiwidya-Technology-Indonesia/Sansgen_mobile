import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

import 'package:get/get.dart';
import 'package:sansgen/keys/assets_icons.dart';
import 'package:sansgen/utils/ext_context.dart';

import '../controllers/kategori_controller.dart';

class KategoriView extends GetView<KategoriController> {
  const KategoriView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('  Kategori', style: context.titleLarge),
        backgroundColor: context.colorScheme.background,
        bottom: bottomAppBar(context),
      ),
      body: Column(
        children: [
          const Gap(12),
          filterCategory(context),
          const Gap(16),
          Expanded(
            child: componentCard(
              title: 'Hasil',
              context: context,
              heightCom: context.height,
              widthCom: double.infinity,
              scrollDirection: Axis.vertical,
              physics: const AlwaysScrollableScrollPhysics(),
              itemCount: controller.bookList.length,
              itemBuilder: (context, index) {
                final book = controller.bookList[index];
                return cardPopuler(book, context);
              },
            ),
          ),
        ],
      ),
    );
  }

  SingleChildScrollView filterCategory(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Padding(
        padding: const EdgeInsets.only(left: 16),
        child: Row(
          children: controller.kategoriList
              .map(
                (e) => Container(
                  height: 36,
                  padding: const EdgeInsets.all(10.0),
                  margin: const EdgeInsets.only(right: 6),
                  decoration: BoxDecoration(
                    color: context.colorScheme.surface.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    e,
                    style: context.labelMedium.copyWith(
                      color: context.colorScheme.surface,
                    ),
                  ),
                ),
              )
              .toList(),
        ),
      ),
    );
  }

  Container cardPopuler(Map<String, String> book, BuildContext context) {
    return Container(
      width: double.infinity,
      height: 160,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      decoration: BoxDecoration(
        // color: context.colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              book['image']!,
              height: 160,
              width: 130,
              fit: BoxFit.cover,
            ),
          ),
          const Gap(12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(book['name']!, style: context.titleSmallBold),
              const Gap(4),
              Text(book['kategori']!, style: context.labelSmall),
              const Gap(4),
              Container(
                height: 20,
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: context.colorScheme.onBackground,
                  borderRadius: BorderRadius.circular(0),
                ),
                child: Text(
                  book['kategori']!,
                  style: context.labelSmall.copyWith(
                    color: context.colorScheme.primary,
                    height: 1,
                  ),
                ),
              ),
              const Gap(4),
              Text(
                '70 bab',
                style: context.labelSmall.copyWith(
                  color: context.colorScheme.secondary,
                ),
              ),
              Text('Sinopsis :', style: context.labelSmallBold),
            ],
          ),
        ],
      ),
    );
  }

  SizedBox componentCard({
    required String title,
    required BuildContext context,
    required double heightCom,
    required double widthCom,
    required Axis scrollDirection,
    required ScrollPhysics physics,
    required int itemCount,
    required Widget? Function(BuildContext, int) itemBuilder,
  }) {
    return SizedBox(
      height: heightCom,
      width: widthCom,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(title, style: context.titleMedium),
                Text(
                  'Lainnya',
                  style: context.labelLarge.copyWith(
                    decoration: TextDecoration.underline,
                    decorationThickness: 2,
                    decorationStyle: TextDecorationStyle.solid,
                    decorationColor: context.colorScheme.secondary,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: itemCount,
              shrinkWrap: true,
              scrollDirection: scrollDirection,
              physics: physics,
              itemBuilder: itemBuilder,
            ),
          ),
        ],
      ),
    );
  }

  PreferredSize bottomAppBar(BuildContext context) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(40),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Card(
          elevation: 4,
          child: TextFormField(
            decoration: InputDecoration(
              hintText: 'Cari',
              filled: true,
              fillColor: context.colorScheme.background,
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(12),
              ),
              contentPadding: const EdgeInsets.symmetric(
                vertical: 12,
                horizontal: 16,
              ),
              prefixIcon: Padding(
                padding: const EdgeInsets.all(16.0),
                child: SvgPicture.asset(
                  KeysAssetsIcons.search,
                  height: 13,
                  colorFilter: ColorFilter.mode(
                    context.colorScheme.onSecondary,
                    BlendMode.srcIn,
                  ),
                ),
              ),
              suffixIcon: Padding(
                padding: const EdgeInsets.all(16.0),
                child: SvgPicture.asset(
                  KeysAssetsIcons.close,
                  height: 13,
                  colorFilter: ColorFilter.mode(
                    context.colorScheme.onSecondary,
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
