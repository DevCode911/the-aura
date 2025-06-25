import 'package:get/get.dart';
import 'package:the_aura/constant/asset_path.dart';

class OnboardingController extends GetxController {
  final RxInt currentIndex = 0.obs;

  final List<Map<String, String>> screenItems = [
    {"image": AssetPath.ob1, "title": "Style Beyond Gender"},
    {"image": AssetPath.ob2, "title": "Easy Service booking & Scheduling"},
    {
      "image": AssetPath.ob3,
      "title":
          "Get Beauty parlour at your home & other Personal Grooming needs",
    },
  ];

  void nextSlide() {
    if (currentIndex.value < screenItems.length - 1) {
      currentIndex.value++;
    } else {}
  }

  void skip() {
    currentIndex.value = screenItems.length - 1;
  }
}
