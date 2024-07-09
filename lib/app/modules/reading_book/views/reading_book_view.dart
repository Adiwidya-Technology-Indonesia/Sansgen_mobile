import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

import 'package:get/get.dart';
import 'package:sansgen/keys/assets_icons.dart';
import 'package:sansgen/utils/ext_context.dart';

import '../controllers/reading_book_controller.dart';

class ReadingBookView extends GetView<ReadingBookController> {
  const ReadingBookView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ReadingBookView'),
        backgroundColor: context.colorScheme.primary,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: context.colorScheme.secondaryContainer,
            child: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => Get.back(),
            ),
          ),
        ),
        actions: [
          IconButton(
            onPressed: controller.openDrawer,
            icon: SvgPicture.asset(KeysAssetsIcons.timer),
          ),
        ],
        // centerTitle: true,
      ),
      key: controller.scaffoldKey,
      drawer: contentDrawer(context),
      body: const Center(
        child: Text(
          'ReadingBookView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
      bottomNavigationBar: bottomNavBarReading(
        context: context,
        chapter:
            controller.book.listChapter.indexOf(controller.chapter).toString(),
        onTapPrevious: () {},
        onTapNext: () {},
        onTapDrawerChapter: controller.openDrawer,
      ),
    );
  }

  Drawer contentDrawer(BuildContext context) {
    return Drawer(
      backgroundColor: context.colorScheme.primary,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(0),
      ),
      width: context.width * 0.55,
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          headerDrawer(context),
          Divider(
            color: context.colorScheme.onPrimary,
            height: 1,
          ),
          ...controller.book.listChapter.map(
            (e) => cardDrawer(e, context),
          ),
        ],
      ),
    );
  }

  Container headerDrawer(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          const Gap(20),
          Image.network(
            width: 140,
            height: 200,
            controller.book.image,
          ),
          const Gap(8),
          Text(
            controller.book.title,
            style: context.titleLargeBold,
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              'Total: ${controller.book.listChapter.length} Bab',
              style: context.titleSmall,
            ),
          ),
        ],
      ),
    );
  }

  Padding cardDrawer(int e, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 8,
      ),
      child: GestureDetector(
        onTap: () => controller.setCurrentChapter(e),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: context.width * 0.4,
              child: Text(
                'lorem ipsum dnkdnsndsc dcjdk c cjdbcjkd',
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: context.titleMedium.copyWith(
                  color: context.colorScheme.onPrimary,
                  overflow: TextOverflow.ellipsis,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            Text(e.toString(), style: context.titleMediumBold),
          ],
        ),
      ),
    );
  }

  Padding bottomNavBarReading({
    required BuildContext context,
    required String chapter,
    void Function()? onTapPrevious,
    void Function()? onTapNext,
    void Function()? onTapDrawerChapter,
  }) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: onTapPrevious,
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: context.colorScheme.surface,
                borderRadius: const BorderRadius.all(Radius.circular(12)),
              ),
              child: const Icon(Icons.arrow_back_ios_rounded),
            ),
          ),
          ElevatedButton(
            onPressed: onTapDrawerChapter,
            style: ElevatedButton.styleFrom(
              minimumSize: Size(context.width * 0.65, 40),
              backgroundColor: context.colorScheme.onSecondary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Obx(() => Text('Bab ${controller.currentChapter}')),
          ),
          GestureDetector(
            onTap: onTapNext,
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: context.colorScheme.surface,
                borderRadius: const BorderRadius.all(Radius.circular(12)),
              ),
              child: const Center(
                  child: Icon(
                Icons.arrow_forward_ios_rounded,
              )),
            ),
          ),
        ],
      ),
    );
  }
}
