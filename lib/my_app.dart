import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:the_aura/res/app_theme/app_theme.dart';
import 'package:the_aura/res/routes/routes.dart';
import 'package:the_aura/res/routes/routes_name.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // ValueNotifier<ThemeMode> themeNotifier = ValueNotifier(ThemeMode.light);
    final String intialRoute;

    if (FirebaseAuth.instance.currentUser != null) {
      intialRoute = RoutesName.bodyPage;
    } else {
      intialRoute = RoutesName.splashScreen;
    }
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppThemes.light, // Light theme
      darkTheme: AppThemes.dark, // dark mod
      themeMode: ThemeMode.system,
      initialRoute: intialRoute,
      getPages: Routes.routes,
    );
  }
}
