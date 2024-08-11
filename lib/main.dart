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
  await dotenv.load(fileName: ".env");
  PrefService prefService = PrefService();
  await prefService.prefInit();
  String isToken = prefService.getUserToken ?? '';
  log(prefService.getUserToken ?? 'kosong', name: 'token login');
  String initialRoutes = isToken == '' ? Routes.LOGIN : Routes.ON_BOARDING;
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
