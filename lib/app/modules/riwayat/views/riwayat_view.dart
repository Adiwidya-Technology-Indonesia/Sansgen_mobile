import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:sansgen/utils/ext_context.dart';

import '../controllers/riwayat_controller.dart';

class RiwayatView extends GetView<RiwayatController> {
  const RiwayatView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: controller.listPage.length,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('  Riwayat Baca'),
          backgroundColor: context.colorScheme.background,
          bottom: TabBar(
            padding: const EdgeInsets.symmetric(horizontal: 0),
            indicatorColor: context.colorScheme.primary,
            dividerColor: context.colorScheme.primary,
            onTap: (index) {
              controller.setCurrentIndex(index);
            },
            tabs: [
              Obx(
                () => cardTabBar(
                  context: context,
                  title: 'Belum Selesai di Baca',
                  color: controller.getSelectedIndex == 0
                      ? context.colorScheme.surface
                      : context.colorScheme.secondaryContainer,
                ),
              ),
              Obx(
                () => cardTabBar(
                  context: context,
                  title: 'Sudah Selesai di Baca',
                  color: controller.getSelectedIndex == 1
                      ? context.colorScheme.surface
                      : context.colorScheme.secondaryContainer,
                ),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: controller.listPage,
        ),
      ),
    );
  }

  Container cardTabBar({
    required BuildContext context,
    required String title,
    required Color color,
  }) {
    return Container(
      height: 40,
      width: context.width,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Tab(text: title),
    );
  }
}
