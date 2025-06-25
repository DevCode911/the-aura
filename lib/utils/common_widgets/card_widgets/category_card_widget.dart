import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:the_aura/res/routes/routes_name.dart';
import 'package:the_aura/view_models/category/category.dart';
import 'package:the_aura/view_models/services/service_model.dart';
import 'package:the_aura/view_models/sub_category_service/sub_category_model.dart';
import '../../../res/api_urls/api_url.dart';
import '../../../res/app_theme/app_colors.dart';

class CategoryCardWidget extends StatelessWidget {
  const CategoryCardWidget({
    super.key,
    this.icon,
    this.subCategoryData,
    this.service,
    this.category,
    this.goToSubCategoryPage = true,
  });

  final Data? subCategoryData;
  final Service? service;
  final Category? category;
  final IconData? icon;
  final bool goToSubCategoryPage;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final double cardWidth = screenWidth * 0.35;
    final double cardHeight = cardWidth * 1.6;

    final String imageUrl =
        subCategoryData?.image != null
            ? "${ApiUrl.baseUrl}${subCategoryData!.image!.startsWith("/") ? "" : "/"}${subCategoryData!.image}"
            : category?.image != null
            ? "${ApiUrl.baseUrl}${category!.image!.startsWith("/") ? "" : "/"}${category!.image}"
            : "https://demofree.sirv.com/nope-not-here.jpg";

    final String name = subCategoryData?.name ?? category?.name ?? 'No Name';

    return InkWell(
      borderRadius: BorderRadius.circular(20),

      onTap: () {
        if (goToSubCategoryPage && subCategoryData != null) {
          Get.toNamed(
            RoutesName.servicesPage,
            arguments: {
              'subCategory': subCategoryData,
              'category': category, // Pass the Category object
            },
          );
          print(category!.name ?? "category name men and women is null");
        } else if (!goToSubCategoryPage && category != null) {
          Get.toNamed(
            RoutesName.subcategoryservicesPage,
            arguments: {
              'category': category, // Pass the Category object
            },
          );
        }
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
          children: [
            // Image section
            Container(
              height: cardHeight * 0.60,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(20),
                ),
              ),
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(20),
                ),
                child: Image.network(
                  imageUrl,
                  fit: BoxFit.cover,
                  frameBuilder: (
                    BuildContext context,
                    Widget child,
                    int? frame,
                    bool wasSynchronouslyLoaded,
                  ) {
                    if (wasSynchronouslyLoaded) return child;
                    return AnimatedOpacity(
                      opacity: frame == null ? 0 : 1,
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeIn,
                      child: child,
                    );
                  },
                  errorBuilder:
                      (context, error, stackTrace) => const Center(
                        child: Icon(Icons.broken_image, size: 40),
                      ),
                ),
              ),
            ),

            //  Text section - centered
            Expanded(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    name,
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// loading cards

class CategoryCardLoadingWidget extends StatelessWidget {
  const CategoryCardLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final double cardWidth = screenWidth * 0.35;
    final double cardHeight = cardWidth * 1.6;

    final isDark = Theme.of(context).brightness == Brightness.dark;
    final placeholderColor =
        isDark ? Colors.grey.shade900 : Colors.grey.shade300;

    return Container(
      width: cardWidth,
      height: cardHeight,
      decoration: BoxDecoration(
        color: placeholderColor,
        borderRadius: BorderRadius.circular(20),
      ),
    );
  }
}
