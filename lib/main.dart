import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:sansgen/theme/app_theme.dart';

import 'app/routes/app_pages.dart';

Future main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  String isIdLogin = 'hjvhv';
  // final prefs = await SharedPreferences.getInstance();
  // String? isLogin = prefs.getString("idLogin") ?? '';
  String initialRoutes =
      isIdLogin == '' ? Routes.ON_BOARDING : Routes.DASHBOARD;
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
    );
  }
}
