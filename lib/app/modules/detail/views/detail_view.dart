import 'dart:developer';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

import 'package:get/get.dart';
import 'package:sansgen/keys/assets_icons.dart';
import 'package:sansgen/utils/ext_context.dart';

import '../controllers/detail_controller.dart';

class DetailView extends GetView<DetailController> {
  const DetailView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: context.colorScheme.primary,
        title: const Text('DetailView'),
      ),
      body: Stack(
        alignment: AlignmentDirectional.topCenter,
        children: [
          contentHeader(
            context: context,
            image: controller.book.image,
          ),
          contentDetail(
            context: context,
            title: controller.book.title,
            image: controller.book.image,
            rating: controller.book.manyRatings,
            sinopsis: controller.book.sinopsis,
          ),
        ],
      ),
    );
  }

  Column contentDetail({
    required BuildContext context,
    required String title,
    required String image,
    required double rating,
    required String sinopsis,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        const Gap(80),
        Image.network(image, width: 180, height: 240),
        const Gap(20),
        Text(title, style: context.titleLargeBold),
        const Gap(8),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            children: [
              RatingBar.builder(
                initialRating: rating,
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemSize: 28,
                itemCount: 5,
                itemPadding: const EdgeInsets.symmetric(horizontal: 1),
                itemBuilder: (context, _) => const Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                onRatingUpdate: (rating) {
                  log(rating.toString(), name: 'rating');
                },
              ),
              Text(rating.toString()),
              const Spacer(),
              SvgPicture.asset(
                KeysAssetsIcons.komen,
                width: 24,
                height: 24,
              ),
              const Gap(10),
              SvgPicture.asset(
                KeysAssetsIcons.like,
                width: 24,
                height: 24,
              ),
            ],
          ),
        ),
        const Gap(12),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            sinopsis,
            textAlign: TextAlign.center,
          ),
        ),
        const Spacer(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(double.infinity, 40),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text('Baca'),
          ),
        ),
        const Gap(20),
      ],
    );
  }

  Container contentHeader({
    required BuildContext context,
    required String image,
  }) {
    return Container(
      height: context.height * 0.3,
      width: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          image: Image.network(image).image,
        ),
      ),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0),
        child: Container(
          decoration: BoxDecoration(color: Colors.white.withOpacity(0.0)),
        ),
      ),
    );
  }
}
