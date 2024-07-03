import 'package:flutter/material.dart';
import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:sansgen/utils/ext_context.dart';

import '../controllers/dashboard_controller.dart';

class DashboardView extends GetView<DashboardController> {
  const DashboardView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DashboardView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'DashboardView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
      bottomNavigationBar: Obx(
        () => bottomBarSnake(context),
      ),
    );
  }

  SnakeNavigationBar bottomBarSnake(BuildContext context) {
    return SnakeNavigationBar.color(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      currentIndex: controller.selectedIndex,
      snakeViewColor: context.colorScheme.surface,
      backgroundColor: context.colorScheme.background,
      selectedItemColor: context.colorScheme.background,
      unselectedItemColor: context.colorScheme.onSecondary,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      onTap: (value) {
        controller.setCurrentIndex(value);
      },
      items: controller.pages.map(
        (e) {
          return BottomNavigationBarItem(
            label: e.title,
            icon: Container(
              height: 50,
              width: 50,
              margin: const EdgeInsets.all(0),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: controller.selectedIndex == e.index
                    ? context.colorScheme.surface
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(30),
              ),
              child: SvgPicture.asset(
                e.icon,
                color: controller.selectedIndex == e.index
                    ? context.colorScheme.background
                    : context.colorScheme.onSecondary,
              ),
            ),
          );
        },
      ).toList(),
    );
  }
}
