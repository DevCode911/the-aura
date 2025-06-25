import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../res/api_urls/api_url.dart';
import '../../../res/app_theme/app_colors.dart';
import '../../../res/routes/routes_name.dart';
import '../../../view_models/category/category.dart';
import '../../../view_models/category/category_controller.dart';
import '../../../view_models/sub_category_service/sub_category_controller.dart';

class HomeCategoryCardWidget extends StatelessWidget {
  final Category? category;

  const HomeCategoryCardWidget({super.key, this.category});

  @override
  Widget build(BuildContext context) {
    final categoryController = Get.find<CategoryController>();
    final viewServiceController = Get.find<SubCategoryController>();

    final screenWidth = MediaQuery.of(context).size.width;
    final double cardWidth = screenWidth * 0.35;
    final double cardHeight = cardWidth * 1.7;

    final String imageUrl =
        category?.image != null
            ? "${ApiUrl.baseUrl}${category!.image!.startsWith("/") ? "" : "/"}${category!.image}"
            : "https://demofree.sirv.com/nope-not-here.jpg";

    final String categoryName = category?.name ?? 'No Name';

    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
        viewServiceController.isWishList.value = categoryName != "Shop";
        categoryController.selectedCategoryName.value = categoryName;

        Get.toNamed(
          RoutesName.subcategoryservicesPage,
          arguments: {'category': category},
        );
      },
      child: Container(
        width: cardWidth,
        height: cardHeight,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color:
              Theme.of(context).brightness == Brightness.dark
                  ? Colors.black
                  : Colors.white,
          border: Border.all(color: AppColors.grey.withAlpha(100)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // 🖼️ Image Section
            Container(
              height: cardHeight * 0.65,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: BorderRadius.circular(20),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(
                  imageUrl,
                  fit: BoxFit.cover,
                  errorBuilder:
                      (context, error, stackTrace) => const Center(
                        child: Icon(Icons.broken_image, size: 40),
                      ),
                ),
              ),
            ),

            const SizedBox(height: 8),

            // 🏷️ Category Name
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Text(
                categoryName,
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                  color: AppColors.lightPrimary,
                ),
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),

            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
