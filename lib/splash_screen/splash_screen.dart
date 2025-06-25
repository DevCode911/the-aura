import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:the_aura/constant/asset_path.dart';
import 'package:the_aura/res/routes/routes_name.dart';

import '../res/app_theme/app_colors.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      Get.offAllNamed(RoutesName.onBoardingScreenOne);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightPrimary,
      body: Center(
        child: TweenAnimationBuilder(
          tween: Tween<double>(begin: 200, end: 300),
          duration: const Duration(seconds: 5),
          builder: (context, double size, child) {
            return Image.asset(AssetPath.auraImage, width: size);
          },
        ),
      ),
    );
  }
}
