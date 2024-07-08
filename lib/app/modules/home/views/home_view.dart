import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import 'package:get/get.dart';
import 'package:sansgen/model/books.dart';
import 'package:sansgen/utils/ext_context.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarCustom(context),
      body: ListView(
        children: [
          const Gap(40),
          componentCard(
            title: 'Pilihan terbaik untukmu',
            context: context,
            heightCom: 220,
            widthCom: double.infinity,
            scrollDirection: Axis.horizontal,
            physics: const AlwaysScrollableScrollPhysics(),
            itemCount: controller.bookList.length,
            itemBuilder: (context, index) {
              final book = controller.bookList[index];
              return cardTerbaikUntukmu(
                book: book,
                onTap: () {
                  controller.toDetails(book);
                },
              );
            },
          ),
          const Gap(12),
          componentCard(
            title: 'Populer',
            context: context,
            heightCom: context.height,
            widthCom: double.infinity,
            scrollDirection: Axis.vertical,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: controller.bookList.length,
            itemBuilder: (context, index) {
              final book = controller.bookList[index];
              return cardPopuler(
                book: book,
                context: context,
                onTap: () {
                  controller.toDetails(book);
                },
              );
            },
          ),
        ],
      ),
    );
  }

  GestureDetector cardPopuler({
    required BookModel book,
    required BuildContext context,
    required Function() onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 87,
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
                book.image,
                height: 87,
                width: 76,
                fit: BoxFit.cover,
              ),
            ),
            const Gap(12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(book.title, style: context.titleSmallBold),
                Text(book.category, style: context.labelSmall),
              ],
            ),
          ],
        ),
      ),
    );
  }

  GestureDetector cardTerbaikUntukmu({
    required BookModel book,
    required Function() onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(left: 16),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.network(
            book.image,
            height: 196,
            width: 149,
            fit: BoxFit.cover,
          ),
        ),
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

  AppBar appBarCustom(BuildContext context) {
    return AppBar(
      backgroundColor: context.colorScheme.primary,
      flexibleSpace: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              context.colorScheme.onSecondaryContainer,
              context.colorScheme.primaryContainer,
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Halo!',
            style: context.titleMedium
                .copyWith(color: context.colorScheme.primary),
          ),
          Text(
            'Rahmat Hidayat',
            style: context.titleMediumBold
                .copyWith(color: context.colorScheme.primary),
          ),
        ],
      ),
      actions: [
        GestureDetector(
          onTap: () {},
          child: const SizedBox(
            width: 50,
            height: 50,
            child: CircleAvatar(
              child: Icon(Icons.person_outline_rounded),
            ),
          ),
        ),
        const Gap(20),
      ],
      bottom: bottomAppBar(context),
    );
  }

  PreferredSize bottomAppBar(BuildContext context) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(60.0),
      child: Expanded(
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Positioned(
              bottom: -30,
              left: 0,
              right: 0,
              child: Container(
                width: 100,
                height: 80,
                margin: const EdgeInsets.symmetric(horizontal: 40),
                decoration: BoxDecoration(
                  color: context.colorScheme.primary,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      offset: const Offset(0, 2),
                      color: context.colorScheme.secondary,
                      blurRadius: 9,
                      spreadRadius: 0.5,
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    dataHeader(context, title: '10m', subTitle: 'Reading'),
                    dataHeader(context, title: '10', subTitle: 'Books'),
                    dataHeader(context, title: '10m', subTitle: 'Focus'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Column dataHeader(
    BuildContext context, {
    required String title,
    required String subTitle,
  }) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(title, style: context.titleMediumBold),
        Text(subTitle, style: context.labelLarge),
      ],
    );
  }
}
