import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import 'package:get/get.dart';
import 'package:sansgen/app/modules/audio_bok/controllers/audio_book_controller.dart';
import 'package:sansgen/utils/ext_context.dart';

import '../../../../state/empty.dart';
import '../../../../state/error.dart';
import '../../../../state/loading.dart';

class AudioBookView extends GetView<AudioBookController> {
  const AudioBookView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return controller.obx(
      (state) => Scaffold(
          appBar: appBar(
            ctx: context,
            data: state!,
          ),
          body: SafeArea(
            child: Column(
              children: [
                content(ctx: context, data: state),
              ],
            ),
          )),
      onLoading: const LoadingState(),
      onError: (error) => ErrorState(error: error.toString()),
      onEmpty: const EmptyState(),
    );
  }

  Widget content({
    required BuildContext ctx,
    required ModelDataAudioPage data,
  }) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          height: 480,
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  ctx.colorScheme.primaryContainer,
                  ctx.colorScheme.primaryContainer.withOpacity(0.2),
                ]),
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(40),
              bottomRight: Radius.circular(40),
            ),
          ),
          child: Column(
            children: [
              const Gap(20),
              Container(
                height: 300,
                width: 200,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(data.dataBook.image),
                  ),
                  // color: Colors.red,
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              const Gap(20),
              judul(
                judul: data.dataChapter.title,
                author: data.dataBook.publisher,
                ctx: ctx,
              ),
            ],
          ),
        ),
        Positioned(
          bottom: -25,
          left: 100,
          right: 100,
          child: ElevatedButton(
            onPressed: controller.onAudio,
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              minimumSize: const Size(200, 50),
            ),
            child: const Text('Lihat Teks'),
          ),
        ),
      ],
    );
  }

  AppBar appBar({
    required BuildContext ctx,
    required ModelDataAudioPage data,
  }) {
    return AppBar(
      backgroundColor: ctx.colorScheme.primaryContainer,
      title: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () {},
              child: Card(
                color: ctx.colorScheme.primary.withOpacity(0.6),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(40),
                ),
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.arrow_back_ios_new_outlined,
                  ),
                ),
              ),
            ),
            Text(
              data.dataBook.title,
              style: ctx.titleMedium,
            ),
            Text(
              'Bab ${data.dataChapter.number}',
              style: ctx.titleMedium,
            )
          ],
        ),
      ),
    );
  }

  Column judul(
      {required String judul,
      required String author,
      required BuildContext ctx}) {
    return Column(
      children: [
        Text(judul, style: ctx.titleLargeBold),
        const Gap(20),
        Text('di Publis Oleh', style: ctx.titleMediumBold),
        Text(author)
      ],
    );
  }
}
