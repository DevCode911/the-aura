import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:the_aura/res/app_theme/app_colors.dart';
import 'package:the_aura/utils/common_utils/buttons/my_elevated_button_widget.dart';
import 'package:the_aura/controller/onboarding_controller.dart';
import 'package:the_aura/utils/common_utils/circle_image/my_circle_avtar_widget.dart';
import 'package:the_aura/view/login_screen_pages/login_page.dart';

class OnBoardingScreenOnePage extends StatelessWidget {
  OnBoardingScreenOnePage({super.key});
  final slideController = Get.find<OnboardingController>();

  // function : off A page and go B page
  void navigationWithAnimation(Widget page) {
    Get.off(
      () => page,
      transition: Transition.downToUp,
      duration: const Duration(seconds: 2),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 60, left: 20, right: 20),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 30,
                  width: 70,
                  child: MyElevatedButtonWidget(
                    buttonName: "Skip",
                    buttonStyle: Theme.of(
                      context,
                    ).elevatedButtonTheme.style!.copyWith(
                      shape: WidgetStatePropertyAll(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                    ),
                    onPressed: () {
                      navigationWithAnimation(LoginSignUpPage());
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),
            Obx(() {
              final item =
                  slideController.screenItems[slideController
                      .currentIndex
                      .value];
              return AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                child: MyCircleAvtarWidget(
                  key: ValueKey(item['image']),
                  imagePath: item['image']!,
                ),
              );
            }),

            const Spacer(),

            Obx(
              () => Text(
                "${slideController.screenItems[slideController.currentIndex.value]["title"]}",
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.w400),
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
            ),
            const SizedBox(height: 30),
            Obx(
              () => AnimatedSmoothIndicator(
                activeIndex: slideController.currentIndex.value,
                count: slideController.screenItems.length,
                effect: ExpandingDotsEffect(
                  dotHeight: 10,
                  dotWidth: 10,
                  activeDotColor: AppColors.lightPrimary,
                  dotColor: AppColors.accent,
                ),
              ),
            ),
            const SizedBox(height: 30),
            Obx(() {
              final isLast =
                  slideController.currentIndex.value ==
                  slideController.screenItems.length - 1;
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: SizedBox(
                  height: 45,
                  child: MyElevatedButtonWidget(
                    icon: CupertinoIcons.arrow_right,
                    isIcon: true,
                    buttonName: isLast ? "Finish" : "Next",
                    textStyle: Theme.of(context).textTheme.headlineSmall!
                        .copyWith(color: AppColors.lightTextcolor),
                    onPressed: () {
                      if (isLast) {
                        navigationWithAnimation(LoginSignUpPage());
                      } else {
                        slideController.nextSlide();
                      }
                    },
                  ),
                ),
              );
            }),
            const SizedBox(height: 90),
          ],
        ),
      ),
    );
  }
}
