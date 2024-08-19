import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:sansgen/services/prefs.dart';
import 'package:sansgen/theme/app_theme.dart';

import 'app/routes/app_pages.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  PrefService prefService = PrefService();

  await dotenv.load(fileName: ".env");
  await prefService.prefInit();
  String isToken = prefService.getUserToken ?? '';
  bool isOnBoarding = prefService.getOnBoarding ?? false;
  log(isToken, name: 'token login');

  String onBoarding =
      isOnBoarding == false ? Routes.AUDIO_BOOK : Routes.AUDIO_BOOK;
  String initialRoutes = isToken == '' ? Routes.LOGIN : onBoarding;
  // String initialRoutes = Routes.DETAIL;
  runApp(MyApp(initialRoutes));
}

class MyApp extends StatelessWidget {
  final String initialRoutes;

  const MyApp(this.initialRoutes, {super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Sansgen',
      // debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      getPages: AppPages.routes,
      initialRoute: initialRoutes,
      builder: EasyLoading.init(),
    );
  }
}
