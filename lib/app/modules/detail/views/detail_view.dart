import 'dart:developer';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

import 'package:get/get.dart';
import 'package:sansgen/keys/assets_icons.dart';
import 'package:sansgen/utils/ext_context.dart';

import '../../../../widgets/image_book.dart';
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
            image: controller.dataBook.image,
          ),
          contentDetail(
            context: context,
            title: controller.dataBook.title,
            image: controller.dataBook.image,
            rating: controller.dataBook.manyRatings.toDouble(),
            like: controller.dataBook.manyLikes,
            comment: controller.dataBook.manyComments,
            sinopsis: controller.dataBook.synopsis,
            // listChapter: ,
          ),
        ],
      ),
      resizeToAvoidBottomInset: false,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: ElevatedButton(
          onPressed: () => controller.tapViewBottomSheetChapter(
              controller.listChapter, context),
          style: ElevatedButton.styleFrom(
            minimumSize: const Size(double.infinity, 40),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: const Text('Baca'),
        ),
      ),
    );
  }

  Widget contentDetail({
    required BuildContext context,
    required String title,
    required String image,
    required double rating,
    required int like,
    required int comment,
    required String sinopsis,
    // required List<int> listChapter,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        const Gap(80),
        imageBook(
          image: image,
          width: 180,
          height: 240,
          radius: 8,
        ),
        const Gap(20),
        Text(title, style: context.titleLargeBold),
        const Gap(8),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Obx(
            () => Row(
              children: [
                GestureDetector(
                  onTap: controller.tapViewRating,
                  child: RatingBar.builder(
                    initialRating: controller.averageRate.value,
                    minRating: 1,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    ignoreGestures: true,
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
                ),
                Text(controller.averageRate.value.toString()),
                const Spacer(),
                GestureDetector(
                  onTap: () => controller.tapViewBottomSheetComment(
                    controller.listComments,
                    context,
                  ),
                  child: SvgPicture.asset(
                    KeysAssetsIcons.komen,
                    width: 24,
                    height: 24,
                  ),
                ),
                Text(controller.listComments.length.toString()),
                const Gap(10),
                GestureDetector(
                  onTap: controller.addLike,
                  child: SvgPicture.asset(
                    KeysAssetsIcons.like,
                    width: 20,
                    height: 20,
                    colorFilter: controller.isLikeState.isFalse
                        ? null
                        : ColorFilter.mode(
                            context.colorScheme.surface,
                            BlendMode.srcATop,
                          ),
                  ),
                ),
                Text(controller.listLike.length.toString()),
              ],
            ),
          ),
        ),
        const Gap(12),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            sinopsis,
            textAlign: TextAlign.center,
            maxLines: 10,
          ),
        ),
      ],
    );
  }

  BackdropFilter contentHeader({
    required BuildContext context,
    required String image,
  }) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0),
      child: imageBook(
        image: image,
        width: double.infinity,
        height: 240,
        radius: 0,
      ),
    );
  }
}
