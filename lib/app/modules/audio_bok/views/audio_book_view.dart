import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gap/gap.dart';

import 'package:get/get.dart';
import 'package:sansgen/app/modules/audio_bok/controllers/audio_book_controller.dart';
import 'package:sansgen/utils/ext_context.dart';

class AudioBookView extends GetView<AudioBookController> {
  const AudioBookView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [content(context)],
        ),
      ),
    );
  }

  Container content(BuildContext ctx) {
    return Container(
      height: 600,
      width: double.infinity,
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [ctx.colorScheme.surface, ctx.colorScheme.primary]),
          borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(40),
              bottomRight: Radius.circular(40))),
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              appbar(ctx.titleMedium),
              const Gap(20),
              Column(
                children: [
                  Container(
                    height: 300,
                    width: 200,
                    decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(20)),
                  ),
                  Gap(40),
                  judul(
                      judul: 'Lorem Ipsum',
                      author: 'David Goudreault',
                      ctx: ctx),
                ],
              ),
              const Gap(50),
              ElevatedButton(
                onPressed: controller.onAudio,
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  minimumSize: const Size(200, 50),
                ),
                child: const Text('Lihat Teks'),
              ),
            ],
          )
        ],
      ),
    );
  }

  Padding appbar(TextStyle style) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
              onPressed: () {},
              icon: const Icon(Icons.arrow_back_ios_new_outlined)),
          Text(
            'Agama Dan Peradaban',
            style: style,
          ),
          Text(
            'Bab 1',
            style: style,
          )
        ],
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
        const Text('di Publis Oleh'),
        Text(author)
      ],
    );
  }
}
