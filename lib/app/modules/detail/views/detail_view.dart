import 'dart:developer';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

import 'package:get/get.dart';
import 'package:sansgen/keys/assets_icons.dart';
import 'package:sansgen/utils/ext_context.dart';

import '../../../../state/empty.dart';
import '../../../../state/error.dart';
import '../../../../state/loading.dart';
import '../../../../widgets/image_book.dart';
import '../controllers/detail_controller.dart';

class DetailView extends GetView<DetailController> {
  const DetailView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return controller.obx(
      (state) => Scaffold(
        appBar: AppBar(
          backgroundColor: context.colorScheme.primary,
          title: Text(controller.dataBook.title),
          leading: GestureDetector(
            onTap: controller.backToDashboard,
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Card(
                color: context.colorScheme.primary.withOpacity(0.6),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(40),
                ),
                child: const Padding(
                  padding: EdgeInsets.all(4.0),
                  child: Icon(
                    Icons.arrow_back_ios_new_outlined,
                  ),
                ),
              ),
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Stack(
            alignment: AlignmentDirectional.topCenter,
            children: [
              contentHeader(
                context: context,
                image: controller.dataBook.image!,
              ),
              contentDetail(
                context: context,
                title: controller.dataBook.title,
                image: controller.dataBook.image!,
                rating: controller.dataBook.averageRate.toString(),
                like: controller.dataBook.manyLikes,
                comment: controller.dataBook.manyComments,
                sinopsis: controller.dataBook.synopsis,
                // listChapter: ,
              ),
            ],
          ),
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
      ),
      onLoading: const LoadingState(),
      onError: (error) => ErrorState(error: error.toString()),
      onEmpty: const EmptyState(),
    );
  }

  Widget contentDetail({
    required BuildContext context,
    required String title,
    required String image,
    required String rating,
    required int like,
    required int comment,
    required String sinopsis,
    // required List<int> listChapter,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        const Gap(80),
        Card(
          elevation: 8,
          child: imageBook(
            image: image,
            width: 180,
            height: 240,
            radius: 8,
          ),
        ),
        const Gap(20),
        Text(
          title,
        textAlign: TextAlign.center,
          style: context.titleLargeBold,
        ),
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
          child: dataSinopsis(context, sinopsis),
        ),
        const Gap(60),
      ],
    );
  }

  Widget dataSinopsis(BuildContext ctx, String sinopsis) {
    return Html(data: sinopsis, style: {
      "div": Style(
        fontSize: FontSize.medium,
        fontStyle: FontStyle.normal,
        alignment: Alignment.center,
        textAlign: TextAlign.center,
        // maxLines: 7,
        // textOverflow: TextOverflow.ellipsis,
      )
    });
  }

  SizedBox contentHeader({
    required BuildContext context,
    required String image,
  }) {
    return SizedBox(
      width: double.infinity,
      height: 240,
      child: Stack(
        fit: StackFit.expand,
        children: [
          imageBook(
            image: image,
            width: double.infinity,
            height: 240,
            radius: 0,
          ),
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 4.0, sigmaY: 4.0),
            child: const SizedBox(),
          ),
        ],
      ),
    );
  }
}
